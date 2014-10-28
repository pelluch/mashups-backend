class Link < ActiveRecord::Base
	belongs_to 	:mashup
	belongs_to 	:link_source
end
