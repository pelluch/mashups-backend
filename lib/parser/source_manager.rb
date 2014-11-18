class SourceManager
	@adapters #Lista de todos los adaptadores
	@results #Lista de todos los JSON resultado

	def getData(searchContent, searchParams, timeout, limit)
		source_adapters = Array.new
		parser_objects = {'emol' => EmolSourceAdapter.new(searchContent), 'twitter' => TwitterSourceAdapter.new(searchContent), 
			'gobierno_de_chile' => GovDataSourceAdapter.new(searchContent), 'cnn' => CNNSourceAdapter.new(searchContent),
			'bbc' => BBCSourceAdapter.new(searchContent), 'goodreads' => GoodReadsSourceAdapter.new(searchContent)}

		searchParams.each do |sp|
			source_adapters << parser_objects[sp]
		end
		result = Array.new

		threads = []

		source_adapters.each do |adapter|
			threads << Thread.new { Thread.current[:partial] = adapter.getJSON(timeout, limit) }
			#result += adapter.getJSON(timeout, limit) }
		end

		threads.each do |t|
			t.join
			result << t[:partial]
		end

		#threads.each { |thr| thr.join; result << thr }

		return result

	end
end