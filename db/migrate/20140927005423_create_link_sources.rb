class CreateLinkSources < ActiveRecord::Migration
  def change
    create_table :link_sources do |t|
      t.string :name

      t.timestamps
    end
  end
end
