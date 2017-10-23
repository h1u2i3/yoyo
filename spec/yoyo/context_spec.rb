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

class Blog < Yoyo::Context
  records :article, :comment
end

class Example < Yoyo::Context
end

RSpec.describe Yoyo::Context do
  context "when inherit" do
    let (:example) { Example.instance }
    let (:example_copy) { Example.instance }

    it "should be a singleton class" do
      expect { Example.new }.to raise_error(NoMethodError)
      expect(example.object_id).to equal(example_copy.object_id)
    end

    it "should has the records method as class method" do
      expect(Example.methods).to include(:records)
    end

    it "should has the scope method as class method" do
      expect(Example.methods).to include(:scope)
    end
  end

  context "the context class" do
    let (:article) { Blog.create_article(title: "title", content: "content") }
    let (:methods) { Blog.methods }

    it "instance should contains the records" do
      expect(Blog.instance.records).to eq([:article, :comment])
    end

    it "should respond to the create_* update_* delete_* methods for each records" do
      expect(Blog.respond_to?(:create_article)).to be_truthy
      expect(Blog.respond_to?(:create_article!)).to be_truthy
      expect(Blog.respond_to?(:update_article)).to be_truthy
      expect(Blog.respond_to?(:delete_article)).to be_truthy
      expect(Blog.respond_to?(:create_comment)).to be_truthy
      expect(Blog.respond_to?(:create_comment!)).to be_truthy
      expect(Blog.respond_to?(:update_comment)).to be_truthy
      expect(Blog.respond_to?(:delete_comment)).to be_truthy
    end

    it "should creat a article when use Blog to do the create_article" do
      expect(article).to be_truthy
      expect(article.id).to be_truthy
      expect(article.title).to eq("title")
      expect(article.content).to eq("content")
    end

    it "should change the exist article attribute" do
      article_id = article.id
      Blog.update_article(article_id, title: "other_title")
      updated_article = Article.find(article_id)
      expect(updated_article.title).to eq("other_title")
    end

    it "should delete the exist article" do
      article_id = article.id
      Blog.delete_article(article_id)
      expect { Article.find(article_id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "should have the find_* method" do
      article_id = article.id
      expect(Blog.find_article(article_id).id).to eq(article_id)
      expect(Blog.find_article_by_id(article_id).id).to eq(article.id)
    end

    it "should have the find_* method when do find the second time" do
      article_id = article.id
      Blog.find_article(article_id)
      expect(Blog.methods).to include(:find_article)
      expect(Blog.find_article(article_id).id).to eq(article_id)
    end

    it "should have the udpate_* when do update the second time" do
      article_id = article.id
      Blog.update_article(article_id, title: "first_title")
      expect(Blog.methods).to include(:update_article)
      Blog.update_article(article_id, title: "second_title")
      expect(Article.find(article_id).title).to eq("second_title")
    end
  end
end
