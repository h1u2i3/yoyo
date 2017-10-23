module Yoyo
  class Executor
    def initialize(instance, name, available_method)
      @instance, @name = instance, name
      @klass = Object.const_get(available_method.split("_")[1..-1].join("_").camelize)
      @execute_method = name.to_s.gsub(Regexp.new("_#{@klass.to_s.downcase}"), "").to_sym
    end

    def execute(*args)
      if has_respond?
        case @execute_method
        when /update_/, /delete_/
          add_indirect_method
          record = @klass.send(:find, args[0])
          record.send(@execute_method, *args[1..-1])
        else
          add_direct_method
          @klass.send(@execute_method, *args)
        end
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

      def add_indirect_method(name)
        name, klass, method = @name, @klass, @execute_method
        @instance.singleton_class.class_eval {
          define_method(@name) do |id, *args|
            record = klass.find(id)
            record.send(method, *args)
          end
        }
      end
  end
end
