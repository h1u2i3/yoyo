# just like a bundary of the module
# a group of active_record module
class Blog::Context < Yoyo::Context
  # add a bunch of scope to do some works
  scope :articles_two_weeks_ago, ->() {}
  scope :most_comments_article, ->() {}

  # add a bunch of records that belongs to this context
  records :article, :comment
end

class Blog::Component < Yoyo::Component

end

class Blog::View < Yoyo::View

end
# Step 1:
# just generate the following method for this class
# the create_* methods should send to the class *
Blog.create_article(title: "title", content: "content")
Blog.create_comment(content: "content", article: article)
# and so of the other methods
# like update_*, delete_*

# Step 2:
# the methods to fetch the models in this context?
# just like:
Blog.find(:article, 1)
Blog.where(:article, title: "title")

# and gave a way to add some scopes
Blog.articles_two_weeks_ago
Article.articles_two_weeks_ago
# the difference between the two methods?
# 1. better concept?
# 2. ???

Blog.most_comments_article

# Step 3:
# do we need to send the methods from route and then the controller
# and like this way?
Blog.article_url(article)
Blog.comment_url(article, comment)
# to be honest do we really need this way to do this work?

context_route_for :blog,
  records: [:article, :comment],
  path: "/blog"
