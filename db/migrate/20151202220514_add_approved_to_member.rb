class AddApprovedToMember < ActiveRecord::Migration
  def change
    add_column :members, :approved, :boolean, :default => false, :null => false
    add_index  :members, :approved
  end
end
