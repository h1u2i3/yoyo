class BlogController < ApplicationController
  # just inject the blog flow
  flow :blog

  def index
  end

  def new
  end
end

class Blog < Yoyo::Context
  records :comment, :article
end

# add method for the global flow
class AppFlow < Yoyo::Flow
end

class BlogFlow < AppFlow
  before_flow :user_should_login, :user_should_be_admin

  def create_comment
    builder
      .flow(Blog, :create_comment)
      .flow(Log, :create_log)
      .flow(Notify, :do_notify)
  end
end

# just use xhr to do the job?
class App extends Yoyo::Component
  # the global flows in the app
  # oh
end

class Blog extends App
  # should get the flow object in ruby
  # ont to one map to the blog flow
end

class Blog.Article extends Blog
end

class Blog.Comment extends Blog
end
