class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.string :keyword
      t.integer :value

      t.timestamps
    end
  end
end
