module AI
	module SourceAnalysersAlgorithms
		class News < AI::SourceAnalysersAlgorithms::Generic
			SCORE_FOR_TITLE_MATCH = 20
			def analyse_source(source_element, query)
				title = source_element.description.extras
				score = assign_score(source_element.content, map_reduce(source_element.content), query, title)
				result = AI::Source::ElementRelevance.new
				result.relevance = score

				result.source_element = source_element
				return result
			end

			protected
			def assign_score content, mapped, query, title
				score = 0
				query.split(' ').each do |word|
					if mapped.has_key?(word)
						score += mapped[word]
					end
				end
				query.gsub(/\.|,/, ' ').squeeze(' ').split(' ').each do |word|
			 		score += (title.include?(word) ? SCORE_FOR_TITLE_MATCH : 0)
				end
				score = length_factor(score, content.length)
				return score
			end
		end
	end
end