module ParserAIFacade
	class QueryManager
		# search_params debe ser un arreglo con las fuentes donde se quiere buscar.
		# Ejemplo: [ "emol", "twitter", "gobierno_de_chile", "cnn" ]
		def parse_and_filter query, search_params, limit
			source_manager = SourceManager.new
			parsed_result = source_manager.getData(query, search_params, limit)

			ready_for_ai_json = Array.new

			parsed_result.each do |p|
				ready_for_ai_json << JSON.parse(p)
			end

			ai_processor = AI::SourceElementProcessor.new
			ai_data = ai_processor.build_source_elements(ready_for_ai_json)
			source_elements_by_relevance = ai_processor.get_source_elements_by_relevance(ai_data, query)
			words_by_relevance = ai_processor.get_words_by_relevance(ai_data, query)

			{:source_elements_by_relevance => source_elements_by_relevance.to_json, :words_by_relevance => words_by_relevance.to_json}
			

		end
	end
end