class AddMashupToLinkandKeyword < ActiveRecord::Migration
	def change
		add_column :links, :mashup_id, :integer
		add_column :keywords, :mashup_id, :integer
	end
end
