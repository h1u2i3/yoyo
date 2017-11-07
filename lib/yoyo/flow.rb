module Yoyo
  class Flow
    attr_reader :controller

    def initialize(controller)
      @controller = controller
    end

    def method_missing(name, *args, &block)
      if controller.respond_to?(name)
        controller.send(name, *args, &block)
      else
        super
      end
    end
  end
end
