require "active_record"

conn = { adapter: "sqlite3", database: ":memory:"  }
ActiveRecord::Base.establish_connection(conn)

class Article < ::ActiveRecord::Base
  connection.create_table :articles, force: true do |t|
    t.string :title
    t.text :content
    t.timestamps
  end
end

class Comment < ::ActiveRecord::Base
  connection.create_table :comments, force: true do |t|
    t.text :content
    t.belongs_to :article
    t.timestamps
  end

  belongs_to :article
end
