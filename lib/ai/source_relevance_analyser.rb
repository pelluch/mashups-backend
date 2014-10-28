module AI
	class SourceRelevanceAnalyser

		attr_accessor :algorithms

		def initialize
			self.algorithms = Array.new
			add_algorithm AI::SourceAnalysersAlgorithms::Generic.new
		end
		def analyse(source_element, query)
			algorithms.first.analyse_source(source_element, query)
		end

		def analyse_batch(source_elements, query)
			result = Array.new
			source_elements.each do |se|
				result << analyse(se, query)
			end
			result.sort_by{|e| -e.relevance}
			result
		end

		def add_algorithm algorithm
			self.algorithms << algorithm
		end

	end
end