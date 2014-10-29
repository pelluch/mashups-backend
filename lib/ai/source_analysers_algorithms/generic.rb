module AI
	module SourceAnalysersAlgorithms
		class Generic < AI::SourceAnalysersAlgorithms::Base

			def analyse_source(source_element, query)
				
				score = assign_score(source_element.content, map_reduce(source_element.content), query)
				result = AI::Source::ElementRelevance.new
				result.relevance = score

				result.source_element = source_element
				return result
			end

			private
			def map_reduce content
				mapped = Hash.new
				content.gsub(/\.|,/, ' ').squeeze(' ').split(' ').each do |word|
					if mapped.has_key?(word)
						mapped[word] += 1
					else
						mapped[word] = 1
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
				score = (score * 10000 / content.length).to_i
				return score
			end
		end
	end
end