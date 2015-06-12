class NewsItem < ActiveRecord::Base
  default_scope { order('published_at DESC') }

  has_attached_file :article_image, styles: {
    large: '940x705>'
  }

  validates_attachment_content_type :article_image, :content_type => /\Aimage\/.*\Z/
end
