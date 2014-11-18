class AddTemporalToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mashup_id, :integer
  end
end
