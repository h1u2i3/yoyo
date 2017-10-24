$:.unshift(File.dirname(__FILE__))  # => ["/Users/xiaohui/Ruby/yoyo/lib", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/seeing_is_believing-3.2.0/lib", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/seeing_is_believing-3.2.0/lib", "/usr/local/Cellar/rbenv/1.1.0/rbenv.d/exec/gem-rehash", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/did_you_mean-1.1.0/lib", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/site_ruby/2.4.0", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/site_ruby/2.4.0/x86_64-darwin16", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/site_ruby", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/vendor_ruby/2.4.0", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/vendor_ruby/2.4.0/x86_64-darwin16", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/vendor_ruby", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/2.4.0", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/2.4.0/x86_64-darwin16"]

require "yoyo"           # => true
require "active_record"  # => false

conn = { adapter: "sqlite3", database: ":memory:"  }  # => {:adapter=>"sqlite3", :database=>":memory:"}
ActiveRecord::Base.establish_connection(conn)         # => #<ActiveRecord::ConnectionAdapters::ConnectionPool:0x007fbaec1dbab0 @mon_owner=nil, @mon_count=0, @mon_mutex=#<Thread::Mutex:0x007fbaec1db998>, @query_cache_enabled=#<Concurrent::Map:0x007fbaec1db948 entries=0 default_proc=#<Proc:0x007fbaec1db8f8@/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract/query_cache.rb:27>>, @spec=#<ActiveRecord::ConnectionAdapters::ConnectionSpecification:0x007fbaec1dbf10 @name="primary", @config={:adapter=>"sqlite3", :database=>":memory:"}, @adapter_method="sqlite3_connection">, @checkout_timeout=5, @reaper=#<ActiveRecord::ConnectionAdapters::ConnectionPool::Reaper:0x007fbaec1db880 @pool=#<ActiveRecord::ConnectionAdapters::ConnectionPool:0x007fbaec1dbab0 ...>, @frequency=nil>, @size=5, @thread_cached_conns=#<Concurrent::Map:0x007fbaec1db830 entries=0 default_proc=nil>, @connections=[], @automatic_reconnect=true, @now_conn...

class Article < ::ActiveRecord::Base                     # => ActiveRecord::Base
  connection.create_table :articles, force: true do |t|  # => #<ActiveRecord::ConnectionAdapters::SQLite3Adapter:0x007fbaec1fa8c0 @transaction_manager=#<ActiveRecord::ConnectionAdapters::TransactionManager:0x007fbaec1c8eb0 @stack=[], @connection=#<ActiveRecord::ConnectionAdapters::SQLite3Adapter:0x007fbaec1fa8c0 ...>>, @query_cache={}, @query_cache_enabled=false, @connection=#<SQLite3::Database:0x007fbaec1fb6a8 @tracefunc=nil, @authorizer=nil, @encoding=#<Encoding:UTF-8>, @busy_handler=nil, @collations={}, @functions={}, @results_as_hash=true, @type_translation=nil, @readonly=false>, @owner=#<Thread:0x007fbaea87ef40 run>, @instrumenter=#<ActiveSupport::Notifications::Instrumenter:0x007fbaec1dbd80 @id="bba871649dc58fa21ea5", @notifier=#<ActiveSupport::Notifications::Fanout:0x007fbaeaa16088 @subscribers=[#<ActiveSupport::Notifications::Fanout::Subscribers::Evented:0x007fbaec143508 @pattern="sql.active_record", @delegate=#<ActiveRecord::LogSubscriber:0x007fbaec1439b8 @queue_key="Active...
    t.string :title                                      # => [:title]
    t.text :content                                      # => [:content]
    t.timestamps                                         # => #<ActiveRecord::ConnectionAdapters::SQLite3::TableDefinition:0x007fbaed13ba50 @columns_hash={"id"=>#<struct ActiveRecord::ConnectionAdapters::ColumnDefinition name="id", type=:primary_key, options={:force=>true, :primary_key=>true, :null=>false}, sql_type=nil>, "title"=>#<struct ActiveRecord::ConnectionAdapters::ColumnDefinition name="title", type=:string, options={:primary_key=>false}, sql_type=nil>, "content"=>#<struct ActiveRecord::ConnectionAdapters::ColumnDefinition name="content", type=:text, options={:primary_key=>false}, sql_type=nil>, "created_at"=>#<struct ActiveRecord::ConnectionAdapters::ColumnDefinition name="created_at", type=:datetime, options={:null=>false, :primary_key=>false}, sql_type=nil>, "updated_at"=>#<struct ActiveRecord::ConnectionAdapters::ColumnDefinition name="updated_at", type=:datetime, options={:null=>false, :primary_key=>false}, sql_type=nil>}, @indexes=[], @foreign_keys=[], @primary_keys=n...
  end                                                    # => []

  scope :latest_articles, -> { [] }  # => :latest_articles
end                                  # => :latest_articles

class Comment < ::ActiveRecord::Base                     # => ActiveRecord::Base
  connection.create_table :comments, force: true do |t|  # => #<ActiveRecord::ConnectionAdapters::SQLite3Adapter:0x007fbaec1fa8c0 @transaction_manager=#<ActiveRecord::ConnectionAdapters::TransactionManager:0x007fbaec1c8eb0 @stack=[], @connection=#<ActiveRecord::ConnectionAdapters::SQLite3Adapter:0x007fbaec1fa8c0 ...>>, @query_cache={}, @query_cache_enabled=false, @connection=#<SQLite3::Database:0x007fbaec1fb6a8 @tracefunc=nil, @authorizer=nil, @encoding=#<Encoding:UTF-8>, @busy_handler=nil, @collations={}, @functions={}, @results_as_hash=true, @type_translation=nil, @readonly=false>, @owner=#<Thread:0x007fbaea87ef40 run>, @instrumenter=#<ActiveSupport::Notifications::Instrumenter:0x007fbaec1dbd80 @id="bba871649dc58fa21ea5", @notifier=#<ActiveSupport::Notifications::Fanout:0x007fbaeaa16088 @subscribers=[#<ActiveSupport::Notifications::Fanout::Subscribers::Evented:0x007fbaec143508 @pattern="sql.active_record", @delegate=#<ActiveRecord::LogSubscriber:0x007fbaec1439b8 @queue_key="Active...
    t.text :content                                      # => [:content]
    t.belongs_to :article                                # => [:article]
    t.timestamps                                         # => #<ActiveRecord::ConnectionAdapters::SQLite3::TableDefinition:0x007fbaed0838b0 @columns_hash={"id"=>#<struct ActiveRecord::ConnectionAdapters::ColumnDefinition name="id", type=:primary_key, options={:force=>true, :primary_key=>true, :null=>false}, sql_type=nil>, "content"=>#<struct ActiveRecord::ConnectionAdapters::ColumnDefinition name="content", type=:text, options={:primary_key=>false}, sql_type=nil>, "article_id"=>#<struct ActiveRecord::ConnectionAdapters::ColumnDefinition name="article_id", type=:integer, options={:primary_key=>false}, sql_type=nil>, "created_at"=>#<struct ActiveRecord::ConnectionAdapters::ColumnDefinition name="created_at", type=:datetime, options={:null=>false, :primary_key=>false}, sql_type=nil>, "updated_at"=>#<struct ActiveRecord::ConnectionAdapters::ColumnDefinition name="updated_at", type=:datetime, options={:null=>false, :primary_key=>false}, sql_type=nil>}, @indexes=[[["article_id"], {}]], @f...
  end                                                    # => []

  scope :latest_comments, -> { [] }  # => :latest_comments

  belongs_to :article  # => {"article"=>#<ActiveRecord::Reflection::BelongsToReflection:0x007fbaeaacefc0 @name=:article, @scope=nil, @options={}, @active_record=Comment(id: integer, content: text, article_id: integer, created_at: datetime, updated_at: datetime), @klass=nil, @plural_name="articles", @automatic_inverse_of=nil, @type=nil, @foreign_type="article_type", @constructable=true, @association_scope_cache={}, @scope_lock=#<Thread::Mutex:0x007fbaeaaced18>>}
end                    # => {"article"=>#<ActiveRecord::Reflection::BelongsToReflection:0x007fbaeaacefc0 @name=:article, @scope=nil, @options={}, @active_record=Comment(id: integer, content: text, article_id: integer, created_at: datetime, updated_at: datetime), @klass=nil, @plural_name="articles", @automatic_inverse_of=nil, @type=nil, @foreign_type="article_type", @constructable=true, @association_scope_cache={}, @scope_lock=#<Thread::Mutex:0x007fbaeaaced18>>}

class Blog < Yoyo::Context    # => Yoyo::Context
  records :article, :comment  # => #<Yoyo::Context::ClassMethods::Blog__Builder__:0x007fbaec3411c0>

  fetcher :latest_activity, [:articles, :latest_articles, :comments, :latest_comments]       # => :latest_activity
  sequence :high_rated_article_comments, [:article, :find, :comments, :high_rated_comments]  # => :high_rated_article_comments

  def log
    "do log method!!!!!!"
  end                      # => :log
end                        # => :log

Blog.instance                  # => #<Blog:0x007fbaec343088 @records=[:article, :comment], @builder=#<Yoyo::Context::ClassMethods::Blog__Builder__:0x007fbaec3411c0>>
# Blog.instance.create_article(title: "title", content: "content")
# Blog.create_article(title: "title_cp", content: "content_cp")
#
# Blog.log
Blog.latest_activity.comments  # => []

# >> def high_rated_article_comments(*args)
# >>   @article = Article.find(*args)
# >>   @comments = @article.high_rated_comments
# >>   self
# >> end
