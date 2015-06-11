class CreateNewsItems < ActiveRecord::Migration
  def change
    create_table :news_items do |t|
      t.string :title
      t.text :content
      t.boolean :published
      t.datetime :published_at

      t.timestamps null: false
    end
  end
end
