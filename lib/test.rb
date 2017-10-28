$:.unshift(File.dirname(__FILE__))  # => ["/Users/xiaohui/Ruby/yoyo/lib", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/seeing_is_believing-3.2.0/lib", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/seeing_is_believing-3.2.0/lib", "/usr/local/Cellar/rbenv/1.1.0/rbenv.d/exec/gem-rehash", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/did_you_mean-1.1.0/lib", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/site_ruby/2.4.0", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/site_ruby/2.4.0/x86_64-darwin16", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/site_ruby", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/vendor_ruby/2.4.0", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/vendor_ruby/2.4.0/x86_64-darwin16", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/vendor_ruby", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/2.4.0", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/2.4.0/x86_64-darwin16"]

require "yoyo"           # => true
require "active_record"  # => false

conn = { adapter: "sqlite3", database: ":memory:"  }  # => {:adapter=>"sqlite3", :database=>":memory:"}
ActiveRecord::Base.establish_connection(conn)         # => #<ActiveRecord::ConnectionAdapters::ConnectionPool:0x007fe91b2b3c00 @mon_owner=nil, @mon_count=0, @mon_mutex=#<Thread::Mutex:0x007fe91b2b3ae8>, @query_cache_enabled=#<Concurrent::Map:0x007fe91b2b3ac0 entries=0 default_proc=#<Proc:0x007fe91b2b3a70@/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/activerecord-5.1.4/lib/active_record/connection_adapters/abstract/query_cache.rb:27>>, @spec=#<ActiveRecord::ConnectionAdapters::ConnectionSpecification:0x007fe91b2b8278 @name="primary", @config={:adapter=>"sqlite3", :database=>":memory:"}, @adapter_method="sqlite3_connection">, @checkout_timeout=5, @reaper=#<ActiveRecord::ConnectionAdapters::ConnectionPool::Reaper:0x007fe91b2b39f8 @pool=#<ActiveRecord::ConnectionAdapters::ConnectionPool:0x007fe91b2b3c00 ...>, @frequency=nil>, @size=5, @thread_cached_conns=#<Concurrent::Map:0x007fe91b2b39a8 entries=0 default_proc=nil>, @connections=[], @automatic_reconnect=true, @now_conn...

class Article < ::ActiveRecord::Base                     # => ActiveRecord::Base
  connection.create_table :articles, force: true do |t|  # => #<ActiveRecord::ConnectionAdapters::SQLite3Adapter:0x007fe91c8112a0 @transaction_manager=#<ActiveRecord::ConnectionAdapters::TransactionManager:0x007fe91b2ba848 @stack=[], @connection=#<ActiveRecord::ConnectionAdapters::SQLite3Adapter:0x007fe91c8112a0 ...>>, @query_cache={}, @query_cache_enabled=false, @connection=#<SQLite3::Database:0x007fe91c812880 @tracefunc=nil, @authorizer=nil, @encoding=#<Encoding:UTF-8>, @busy_handler=nil, @collations={}, @functions={}, @results_as_hash=true, @type_translation=nil, @readonly=false>, @owner=#<Thread:0x007fe91b87ef40 run>, @instrumenter=#<ActiveSupport::Notifications::Instrumenter:0x007fe91b2b80c0 @id="e4202b2b3b3f8feccf15", @notifier=#<ActiveSupport::Notifications::Fanout:0x007fe91d8e2c50 @subscribers=[#<ActiveSupport::Notifications::Fanout::Subscribers::Evented:0x007fe91c09c1a0 @pattern="sql.active_record", @delegate=#<ActiveRecord::LogSubscriber:0x007fe91c09d5f0 @queue_key="Active...
    t.string :title                                      # => [:title]
    t.text :content                                      # => [:content]
    t.timestamps                                         # => #<ActiveRecord::ConnectionAdapters::SQLite3::TableDefinition:0x007fe91b2aa678 @columns_hash={"id"=>#<struct ActiveRecord::ConnectionAdapters::ColumnDefinition name="id", type=:primary_key, options={:force=>true, :primary_key=>true, :null=>false}, sql_type=nil>, "title"=>#<struct ActiveRecord::ConnectionAdapters::ColumnDefinition name="title", type=:string, options={:primary_key=>false}, sql_type=nil>, "content"=>#<struct ActiveRecord::ConnectionAdapters::ColumnDefinition name="content", type=:text, options={:primary_key=>false}, sql_type=nil>, "created_at"=>#<struct ActiveRecord::ConnectionAdapters::ColumnDefinition name="created_at", type=:datetime, options={:null=>false, :primary_key=>false}, sql_type=nil>, "updated_at"=>#<struct ActiveRecord::ConnectionAdapters::ColumnDefinition name="updated_at", type=:datetime, options={:null=>false, :primary_key=>false}, sql_type=nil>}, @indexes=[], @foreign_keys=[], @primary_keys=n...
  end                                                    # => []

  scope :latest_articles, -> { [] }  # => :latest_articles
end                                  # => :latest_articles

class Comment < ::ActiveRecord::Base                     # => ActiveRecord::Base
  connection.create_table :comments, force: true do |t|  # => #<ActiveRecord::ConnectionAdapters::SQLite3Adapter:0x007fe91c8112a0 @transaction_manager=#<ActiveRecord::ConnectionAdapters::TransactionManager:0x007fe91b2ba848 @stack=[], @connection=#<ActiveRecord::ConnectionAdapters::SQLite3Adapter:0x007fe91c8112a0 ...>>, @query_cache={}, @query_cache_enabled=false, @connection=#<SQLite3::Database:0x007fe91c812880 @tracefunc=nil, @authorizer=nil, @encoding=#<Encoding:UTF-8>, @busy_handler=nil, @collations={}, @functions={}, @results_as_hash=true, @type_translation=nil, @readonly=false>, @owner=#<Thread:0x007fe91b87ef40 run>, @instrumenter=#<ActiveSupport::Notifications::Instrumenter:0x007fe91b2b80c0 @id="e4202b2b3b3f8feccf15", @notifier=#<ActiveSupport::Notifications::Fanout:0x007fe91d8e2c50 @subscribers=[#<ActiveSupport::Notifications::Fanout::Subscribers::Evented:0x007fe91c09c1a0 @pattern="sql.active_record", @delegate=#<ActiveRecord::LogSubscriber:0x007fe91c09d5f0 @queue_key="Active...
    t.text :content                                      # => [:content]
    t.belongs_to :article                                # => [:article]
    t.timestamps                                         # => #<ActiveRecord::ConnectionAdapters::SQLite3::TableDefinition:0x007fe91b248108 @columns_hash={"id"=>#<struct ActiveRecord::ConnectionAdapters::ColumnDefinition name="id", type=:primary_key, options={:force=>true, :primary_key=>true, :null=>false}, sql_type=nil>, "content"=>#<struct ActiveRecord::ConnectionAdapters::ColumnDefinition name="content", type=:text, options={:primary_key=>false}, sql_type=nil>, "article_id"=>#<struct ActiveRecord::ConnectionAdapters::ColumnDefinition name="article_id", type=:integer, options={:primary_key=>false}, sql_type=nil>, "created_at"=>#<struct ActiveRecord::ConnectionAdapters::ColumnDefinition name="created_at", type=:datetime, options={:null=>false, :primary_key=>false}, sql_type=nil>, "updated_at"=>#<struct ActiveRecord::ConnectionAdapters::ColumnDefinition name="updated_at", type=:datetime, options={:null=>false, :primary_key=>false}, sql_type=nil>}, @indexes=[[["article_id"], {}]], @f...
  end                                                    # => []

  scope :latest_comments, -> { [] }  # => :latest_comments

  belongs_to :article  # => {"article"=>#<ActiveRecord::Reflection::BelongsToReflection:0x007fe91b1ba420 @name=:article, @scope=nil, @options={}, @active_record=Comment(id: integer, content: text, article_id: integer, created_at: datetime, updated_at: datetime), @klass=nil, @plural_name="articles", @automatic_inverse_of=nil, @type=nil, @foreign_type="article_type", @constructable=true, @association_scope_cache={}, @scope_lock=#<Thread::Mutex:0x007fe91b1ba1c8>>}
end                    # => {"article"=>#<ActiveRecord::Reflection::BelongsToReflection:0x007fe91b1ba420 @name=:article, @scope=nil, @options={}, @active_record=Comment(id: integer, content: text, article_id: integer, created_at: datetime, updated_at: datetime), @klass=nil, @plural_name="articles", @automatic_inverse_of=nil, @type=nil, @foreign_type="article_type", @constructable=true, @association_scope_cache={}, @scope_lock=#<Thread::Mutex:0x007fe91b1ba1c8>>}

class Blog < Yoyo::Context    # => Yoyo::Context
  records :article, :comment  # => #<Yoyo::Context::ClassMethods::Blog__Builder__:0x007fe91d84be68>

  fetcher :latest_activity, [:articles, :latest_articles, :comments, :latest_comments]       # => :latest_activity
  sequence :high_rated_article_comments, [:article, :find, :comments, :high_rated_comments]  # => :high_rated_article_comments

  def log
    "do log method!!!!!!"
  end                      # => :log
end                        # => :log

# Blog.instance         # => #<Blog:0x007fefe28d2af0 @records=[:article, :comment], @builder=#<Yoyo::Context::ClassMethods::Blog__Builder__:0x007fefe2890ee8>>
Blog.instance.create_article(title: "title", content: "content")  # => #<Article id: 1, title: "title", content: "content", created_at: "2017-10-28 06:48:11", updated_at: "2017-10-28 06:48:11">
# Blog.create_article(title: "title_cp", content: "content_cp")
#
# Blog.log
# Blog.latest_activity  # => #<struct articles=[], comments=[]>
