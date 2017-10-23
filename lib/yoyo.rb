require "active_support"

module Yoyo
  extend ActiveSupport::Autoload

  autoload :Version
  autoload :Executor
  autoload :Context
end
