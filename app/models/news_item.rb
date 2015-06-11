class NewsItem < ActiveRecord::Base
  default_scope { order('published_at DESC') }
end
