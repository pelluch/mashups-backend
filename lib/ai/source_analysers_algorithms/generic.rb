module AI
	module SourceAnalysersAlgorithms
		class Generic < AI::SourceAnalysersAlgorithms::Base
			SCORE_PER_MATCH = 1
			SCORE_LOSS_BY_LENGTH = 10
			SCORE_BY_LENGTH_FACTOR = 1/1000
			def analyse_source(source_element, query)
				score = assign_score(source_element.content, map_reduce(source_element.content), query)
				result = AI::Source::ElementRelevance.new
				result.relevance = score

				result.source_element = source_element
				return result
			end

			protected
			def map_reduce content
				mapped = Hash.new
				content.gsub(/\.|,/, ' ').squeeze(' ').split(' ').each do |word|
					if mapped.has_key?(word)
						mapped[word] += SCORE_PER_MATCH
					else
						mapped[word] = SCORE_PER_MATCH
					end
				end
				return mapped
			end

			def assign_score content, mapped, query
				score = 0
				query.split(' ').each do |word|
					if mapped.has_key?(word)
						score += mapped[word]
					end
				end
				score = length_factor(score, content.length)
				return score
			end

			def length_factor score, length
				 score - SCORE_LOSS_BY_LENGTH * length * SCORE_BY_LENGTH_FACTOR
			end
		end
	end
end