require "singleton"
require "forwardable"

module Yoyo
  class Context
    METHODS_HEADER = [
      "find_",
      "create_",
      "find_or_create_",
      "update_",
      "delete_"
    ].freeze

    # the context should be a singleton class
    # and it should only be used as a way to gather all the methods
    def self.inherited(subclass)
      # make the subclass be singleton
      # make the subclass get the class methods
      subclass.class_eval {
        include Singleton

        extend ClassMethods
        extend Forwardable

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
          klass = self.class
          klass.respond_to?(name)
        end
      }
    end

    # make the marshal dump or load method to contains the
    # record
    def self._load(text)
      instance.instance_variable_set(:'@records', Marshal.load(text))
      instance
    end

    def _dump(depth)
      Marshal.dump(@records, depth)
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

        self.singleton_class.class_eval {
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
      end

      def scope(name, &block)
      end
    end

  end
end
