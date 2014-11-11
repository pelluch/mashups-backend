module AI
	class TextRelevanceAnalyser

		attr_accessor :algorithms

        def initialize
            self.algorithms = Hash.new
            textalytics =  AI::TextAnalysers::Textalytics.new
            self.algorithms = { :textalytics => textalytics }
        end

		def analyse(source_element, query)
            algorithms[:textalytics].analyse_text(source_element, query)
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