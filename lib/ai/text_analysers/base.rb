module AI
	module TextAnalysers
		class Base

            attr_reader :api_url, :api_key, :api_secret

            def analyse_text(text, query)
                score = assign_score(source_element.content, map_reduce(source_element.content), query)
                result = AI::Source::ElementRelevance.new
                result.relevance = score

                result.source_element = source_element
                return result
            end
		end
	end
end
