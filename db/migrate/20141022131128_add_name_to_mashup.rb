class AddNameToMashup < ActiveRecord::Migration
  def change
    add_column :mashups, :name, :string
  end
end
