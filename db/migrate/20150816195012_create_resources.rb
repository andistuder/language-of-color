class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :title
      t.datetime :published_at
      t.boolean :published
      t.boolean :public_download
      t.text :author
      t.text :summary
      t.text :license
      t.attachment :file

      t.timestamps null: false
    end
  end
end
