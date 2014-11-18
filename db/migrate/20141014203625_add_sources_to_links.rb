class AddSourcesToLinks < ActiveRecord::Migration
  def change
  	add_column :links, :link_source_id, :integer
  end
end
