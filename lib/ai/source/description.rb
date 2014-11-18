module AI
	module Source

		SOURCE_TYPES = [ :emol, :twitter, :gobierno_de_chile, :cnn, :bbc, :goodreads, :other ]		
		class Description
			attr_accessor :url, :type, :extras
		end
	end
end
