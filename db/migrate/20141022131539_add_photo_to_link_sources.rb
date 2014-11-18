class AddPhotoToLinkSources < ActiveRecord::Migration
  def change
    add_column :link_sources, :photo, :string
  end
end
