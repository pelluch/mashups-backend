class Keyword < ActiveRecord::Base
	belongs_to 	:mashup, dependent: :destroy
end
