# YOYO

## Blog Site Steps

### 1. Model Design

#### 1.1 Models

|Model  |            Arrtibutes                |
|-------|--------------------------------------|
|user   | email, name, password                |
|article| title, content                       |
|comment| content                              |
|log    | message                              |

#### 1.2 Relationships

```ruby
class User < ApplicationRecord
  has_many :articles
  has_many :comments
end

class Article < ApplicationRecord
  has_many :comments
  belongs_to :user
end

class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user
end

class Log < ApplicationRecord
end
```

### 2. Context Design

#### 2.1 Context Division

```ruby
# Account
class Account < Yoyo::Context
  records :user
end

# Publish
class Pulisher < Yoyo::Context
  records :article, :comment
end

# LogContext
class LogContext < Yoyo::Context
  records :log
end
```

#### 2.2 Fetcher, Sequence & Other

**The principle**

1. in the context class, all the database operation should be a function, the context will wrap the funciton as a database transaction.
2. cause the normal query are in the model itself, so we should place the complicate query in the context, it should consist of two kinds, the fetcher and the sequence.

```ruby
class Account < Yoyo::Context
  records :user

  def create_sample_user
    create_user(
      name: "xiaohui",
      password: "123456",
      email: "123456@qq.com"
      admin: false
    )
  end

  def create_sample_admin
    create_admin(
      name: "admin",
      password: "678909876",
      email: "123456@qq.com",
      admin: true
    )
  end
end

class Publisher < Yoyo::Context
  records :article, :comment

  fetcher :latest_activity, [
    :articles, :latest_articles,
    :comments, :latest_comments
  ]

  sequence :high_rated_article_comments, [
    :article, :find,
    :comments, :high_rated_comments
  ]

  def add_simple_bloger
    article = create_article(title: "title", content: "content")
    create_comment(content: "comment", article: article)
  end
end

class LogContext < Yoyo::Context
  record :log

  def add_viewer_log(author, viewer)
    create_log(message: "#{viewer} visit #{author} at #{Time.now}")
  end

  def add_create_article_log(author, title)
    create_log(message: "#{authoor} has just create a article #{title}")
  end

  def add_create_comment_log(author, article_title)
    create_log(message: "#{author} has just create a comment to article #{article_title}")
  end
end
```

### 3. The Flow

**Still thinking about this part ...**

For the `business` part, we should realize that all the web request is for a target,
so, in this `YOYO` framework, we call this request target as `flow`.

For example, we want to see a article in the browser,
and we send a request to the server, we just send a show-article-flow request,
and the server should return a view of the article we want to see.

This `flow` concept exists both in the server part and the client part, and for the client part,
this `flow` is the goal of the client, and for the server part, this is just a database/server
operation. So in the view part of this framework, for example, if we visit the homepage of the
website, the web page must contains all the possible flows for the user.

And for the `view` part, this `flow` part must be member of it,
so we can easily fire a flow in the browser.

We should get rid of the `Route` part in the server, the route should/must be
implemented in the client browser.

Cause the route part is implemented in the client browser, so the server didn't concern about
the change of client's url, it should only concern about the flow that send by the client,
and return the flow the client.
