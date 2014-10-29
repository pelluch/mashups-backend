class AddUserToMashup < ActiveRecord::Migration
  def change
  	add_column :mashups, :user_id, :integer
  end
end
