class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :first_name
      t.string :last_name
      t.string :title
      t.string :country_of_residence
      t.string :job_title
      t.string :organisation
      t.string :link
      t.string :email

      t.timestamps null: false
    end
    add_index :members, :email, unique: true
  end
end
