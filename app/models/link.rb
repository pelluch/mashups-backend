class Link < ActiveRecord::Base
	belongs_to 	:mashup, dependent: :destroy
	belongs_to 	:link_source
end
