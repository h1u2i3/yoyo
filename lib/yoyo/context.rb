require "singleton"
require "forwardable"

module Yoyo
  class Context
    METHODS_HEADER = [
      "find_",
      "create_",
      "find_or_create_",
      "update_",
      "delete_",
    ].freeze

    BUILDER_TAIL = "__Builder__".freeze

    # the context should be a singleton class
    # and it should only be used as a way to gather all the methods
    def self.inherited(subclass)
      # make the subclass be singleton
      # make the subclass get the class methods
      subclass.class_eval {
        include Singleton

        extend ClassMethods
        extend Forwardable

        def self.method_added(method_name)
          # just add the delegator as class_method
          # provent to add the delegator method like method_missing respond_to_missing?
          if method_name != :method_missing &&
            method_name != :"respond_to_missing?" &&
              !respond_to?(method_name)
            # just wrap the method in the transactions
            # so make all the steps fall or success the same time
            define_singleton_method(method_name) do |*args|
              ActiveRecord::Base.transaction do
                instance.send(method_name, *args)
              end
            end
          end
        end

        # just delegate the method as class_method
        # like create_* update_*
        def method_missing(name, *args)
          klass = self.class
          if klass.respond_to?(name)
            # create delegator
            klass.class_eval {
              def_delegator klass, name
            }
            # execute the method
            klass.send(name, *args)
          else
            super
          end
        end

        def respond_to_missing?(name, include_all)
          self.class.respond_to?(name)
        end
      }
    end

    # should extends this method to the subclass
    module ClassMethods
      # the active records in this context
      def records(*args)
        # make the context instance contains
        # all the records set in the records function
        instance.instance_variable_set(:'@records', args)

        instance.class_eval {
          attr_reader :records
        }

        singleton_class.class_eval {
          # the method_missing method
          # dispath the method to the right target
          def method_missing(name, *method_args)
            if (available_method = find_available_method(name))
              get_executor(name, available_method).execute(*method_args)
            else
              super
            end
          end

          # check if the context can respond_to the method
          def respond_to_missing?(name, include_all)
            if (available_method = find_available_method(name))
              get_executor(name, available_method).has_respond?
            else
              super
            end
          end

          private

            def get_executor(name, method)
              Executor.new(self, name, method)
            end

            def find_available_method(name)
              available_methods(instance.records).find { |method| Regexp.new(method) === name }
            end

            def available_methods(records)
              METHODS_HEADER.product(records.map(&:to_s)).map(&:join)
            end
        }

        records = instance.records
        attr_accessor_array = records.map {|record| record.to_s.pluralize.to_sym }.concat(records)

        builder_class_string = <<~EOF
          class #{self.to_s + BUILDER_TAIL}
            attr_accessor #{attr_accessor_array.map(&:inspect).join(", ")}
          end

          #{self.to_s + BUILDER_TAIL}.new
        EOF

        builder = eval(builder_class_string)
        instance.instance_variable_set(:'@builder', builder)
      end

      # just create a builder class
      #
      # class Blog__Builder__
      #  attr_accessor :article, :articles, :comment, :comments
      #
      #  # fetcher :latest_activity, [:articles, :latest_articles, :comments, :latest_comments]
      #  def latest_activity
      #    @articles = Article.latest_articles
      #    @comments = Comment.latest_comments
      #  end
      #
      #  # sequence :high_rated_article_comments, [:article, :find, :comments, :high_rated_comments]
      #  def high_rated_article_comments(*args)
      #    @article = Article.find(*args)
      #    @comments = @article.high_rated_comments
      #    self
      #  end
      # end

      def fetcher(name, call_array)
        if call_array.count.even?
          builder = instance.instance_variable_get(:'@builder')
          create_singleton_method(name, builder)
          method_string = <<~EOF
            def #{name}
              #{
                call_array.each_slice(2).map do |arr|
                  line = ""
                  line << "@#{arr.first} = "
                  line << "#{arr.first.to_s.singularize.capitalize}.#{arr.last}"
                end.join("\n  ")
              }
              self
            end
          EOF
          builder.class_eval(method_string)
        else
          raise_argument_error("the call list count should be even")
        end
      end

      def sequence(name, call_array)
        if call_array.count.even?
          builder = instance.instance_variable_get(:'@builder')
          create_singleton_method(name, builder)
          method_string = <<~EOF
            def #{name}(*args)
              #{
                result = ""
                call_array.each_slice(2).each_with_object([]) do |arr, o|
                  if o.empty?
                    o << "@#{arr.first}"
                    result << "#{o.last} = "
                    result << "#{arr.first.to_s.singularize.capitalize}.#{arr.last}(*args)"
                  else
                    temp = o.last
                    o << "@#{arr.first}"
                    result << "#{o.last} = "
                    result << "#{temp}.#{arr.last}"
                  end
                  unless arr.last == call_array.last
                    result << "\n  "
                  end
                end
                result
              }
              self
            end
          EOF
          builder.class_eval(method_string)
        else
          raise_argument_error("the call list count should be even")
        end
      end

      private

        def create_singleton_method(name, builder)
          define_singleton_method(name) do |*args|
            builder.send(name, *args)
          end
        end

        def raise_argument_error(reason)
          raise ArgumentError, reason
        end
    end

  end
end
