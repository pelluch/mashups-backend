module AI
	class SourceElementProcessor

		def get_words_by_relevance(source_elements, query)
			analyser = AI::TextRelevanceAnalyser.new
			analyser.analyse_batch source_elements, query
		end

		def get_source_elements_by_relevance(source_elements, query)
			analyser = AI::SourceRelevanceAnalyser.new
			analyser.analyse_batch source_elements, query
		end

		# Json de ejemplo
		#	[
		#		{
		#			author: "autor", // Opcional
		#			date: "fecha", // Opcional
		#			content: "noticia, twitt, cualquier contenido", 
		#			source:
		#	 		{
		# 				url: "ruta de la fuente",
		#				type: "emol, twitter, gobierno_de_chile, etc",
		#				extras: "cualquier otro parámetro que se quiera entregar, por ejemplo, el número de followers si es un twitt" // Opcional
		#	 		}
		#		},
		#       { author: "autor", date: "fecha", content: "noticia, twitt, cualquier contenido", source: { url: "ruta de la fuente", type: "emol, twitter, gobierno_de_chile, etc", extras: "cualquier otro parámetro que se quiera entregar, por ejemplo, el número de followers si es un twitt"}}
		#	...
		# 	]
		def build_source_elements json
			result = Array.new
			json.each do |source|
				currElem = AI::Source::Element.new
				currElem.author = source['author']
				currElem.date 	= source['date']
				currElem.content= source['content']
				currElem.description = AI::Source::Description.new
				currElem.description.url = source['source']['url']
				currElem.description.type = 'other'
				AI::Source::SOURCE_TYPES.each do |st|
				 	if st.to_s == source['source']['type']
				 		currElem.description.type = st
				 	end
				end
				currElem.description.extras = source['source']['extras']
				result << currElem
			end
			return result
		end
	end
end