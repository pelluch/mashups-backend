class SourceManager
	@adapters #Lista de todos los adaptadores
	@results #Lista de todos los JSON resultado

	def getData(searchContent, searchParams, limit)
		source_adapters = Array.new
		parser_objects = {:emol => EmolSourceAdapter.new(searchContent), :twitter => TwitterSourceAdapter.new(searchContent), :gobierno_de_chile => GovDataSourceAdapter.new(searchContent), :cnn => CNNSourceAdapter.new(searchContent)}

		searchParams.each do |sp|
			source_adapters << parser_objects[sp]
		end
		result = Array.new
		source_adapters.each do |adapter|
			result += adapter.getJson(limit)
		end

		return result

	end
end