class AddArticleImageToNewsItems < ActiveRecord::Migration
  def self.up
    add_attachment :news_items, :article_image
    add_column :news_items, :image_caption, :string
  end

  def self.down
    remove_attachment :news_items, :article_image
    remove_column :news_items, :image_caption, :string
  end
end
