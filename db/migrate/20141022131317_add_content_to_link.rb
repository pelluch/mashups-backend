class AddContentToLink < ActiveRecord::Migration
  def change
    add_column :links, :content, :text
  end
end
