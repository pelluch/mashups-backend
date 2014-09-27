class CreateMashups < ActiveRecord::Migration
  def change
    create_table :mashups do |t|
      t.string :parameters

      t.timestamps
    end
  end
end
