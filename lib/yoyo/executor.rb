module Yoyo
  class Executor
    def initialize(instance, name, available_method)
      @instance, @name = instance, name
      @klass = Object.const_get(available_method.split("_")[1..-1].join("_").camelize)
      @execute_method = name.to_s.gsub(Regexp.new("_#{@klass.to_s.downcase}"), "").to_sym
    end

    def execute(*args)
      # for example
      # if we have a model call Article
      # and there are calls methods for us to call:
      # * Article.create!, Article.create
      # * Article.update_all, Article.update
      # * Article.delete_all, Article.delete
      # so we must not focus on the instance method, cause it is not the
      # context care about
      if has_respond?
        add_direct_method
        @klass.send(@execute_method, *args)
      else
        raise NoMethodError, "there is no ##{@execute_method} method in class #{@klass}"
      end
    end

    def has_respond?
      @klass.respond_to?(@execute_method)
    end

    private

      def add_direct_method
        name, klass, method = @name, @klass, @execute_method
        @instance.singleton_class.class_eval {
          define_method(name) do |*args|
            klass.send(method, *args)
          end
        }
      end
  end
end
