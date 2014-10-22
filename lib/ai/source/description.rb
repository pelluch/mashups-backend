module AI
	module Source

		SOURCE_TYPES = [ :emol, :twitter, :gobierno_de_chile, :cnn, :other ]		
		class Description
			attr_accessor :url, :type
		end
	end
end
