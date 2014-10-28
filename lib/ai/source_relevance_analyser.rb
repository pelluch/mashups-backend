module AI
	class SourceRelevanceAnalyzer

		attr_accessor :algorithms

		def analyse(source_element, query)
		end

		def analyse_batch(source_elements, query)
			result = Array.new
			source_elements.each do |se|
				result << analyse(se, query)
			end
			result
		end

		def add_algorithm algorithm
			self.algorithms << algorithm
		end

	end
end