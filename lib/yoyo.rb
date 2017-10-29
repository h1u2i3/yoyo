require "active_support"
require "active_record"

module Yoyo
  extend ActiveSupport::Autoload

  autoload :Version
  autoload :Executor
  autoload :Context
  autoload :Flow
end
