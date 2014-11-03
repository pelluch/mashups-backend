module AI
	class TextRelevanceAnalyser

		attr_accessor :algorithms

        def initialize
            self.algorithms = Hash.new
            generic =  AI::TextAnalysers::Base.new
            self.algorithms = { :generic => generic }
        end

		def analyse(source_element, query)
            algorithms[:generic].analyse_text(source_element, query)
		end

		def analyse_batch(contents, query)
            result = Array.new
            source_elements.each do |se|
                result << analyse(se, query)
            end
            result.sort_by!{|e| -e.relevance}
            result
		end

	end
end