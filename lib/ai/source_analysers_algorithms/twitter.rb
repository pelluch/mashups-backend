module AI
	module SourceAnalysersAlgorithms
		class Twitter < AI::SourceAnalysersAlgorithms::Generic
			SCORE_BY_FOLLOWERS = 1/100000
			TWITTER_FACTOR = 1.5
			def analyse_source(source_element, query)
				followers = source_element.description.extras.to_i
				score = assign_score(source_element.content, map_reduce(source_element.content), query, followers)
				result = AI::Source::ElementRelevance.new
				result.relevance = score

				result.source_element = source_element
				return result
			end
			
			protected
			def assign_score content, mapped, query, followers
				score = 0
				query.split(' ').each do |word|
					if mapped.has_key?(word)
						score += mapped[word] * TWITTER_FACTOR
					end
				end	
				score += SCORE_BY_FOLLOWERS * followers
				return score
			end
		end
	end
end