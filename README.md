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
# deal with the user login/logout
class Account < Yoyo::Context
  records :user
end

# Publish
# deal with the article/comment things
class Pulish < Yoyo::Context
  records :article, :comment
end

# LogContext
# deal with the website log message
class LogContext < Yoyo::Context
  records :log
end
```

#### 2.2 Fetcher, Sequence & Other

**The principle**

1. in the context class, all the database operation should be a function, the context will wrap the funciton as a database transaction.
2. cause the normal query are in the model itself, so we should place the complicate query in the context, it should consist of two kinds, the fetcher and the sequence.
