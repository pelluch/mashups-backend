module AI
	class SourceRelevanceAnalyser

		attr_accessor :algorithms

		def initialize
			self.algorithms = Hash.new
			generic =  AI::SourceAnalysersAlgorithms::Generic.new
			news =  AI::SourceAnalysersAlgorithms::News.new
			twitter =  AI::SourceAnalysersAlgorithms::Twitter.new

			self.algorithms = {:emol => news, :cnn => news, :twitter => twitter, :gobierno_de_chile => news, :bbc => news}

		end
		def analyse(source_element, query)
			unless (algorithms[source_element.description.type] == nil)
				algorithms[source_element.description.type].analyse_source(source_element, query)	
			else
				algorithms[:cnn].analyse_source(source_element, query)	
			end
		end

		def analyse_batch(source_elements, query)
			result = Array.new
			source_elements.each do |se|
				result << analyse(se, query)
			end
			result.sort_by!{|e| -e.relevance}
			result
		end

		
	end
end