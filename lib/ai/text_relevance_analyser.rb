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

        # Each element has the following form:

        # {"id"=>"0",
        #  "sentiment"=>"NONE",
        #  "categorization"=>[{"code"=>"15054000", "labels"=>["deporte", "fútbol"], "relevance"=>100}],
        #  "entities"=>[{"form"=>"Alexis Sanchez", "type"=>"PERSON", "variants"=>["Alexis Sanchez"], "relevance"=>100}],
        #  "concepts"=>[{"form"=>"fútbol", "variants"=>["futbol"], "relevance"=>100}],
        #  "timeExpressions"=>[],
        #  "moneyExpressions"=>[],
        #  "uris"=>[],
        #  "phoneExpressions"=>[]}

        def update_scores(words_hash, word, relevance)
            word = word.parameterize ' '
            if not words_hash[word]
                words_hash[word] = {
                    count: 1,
                    score: relevance
                }
                return
            end
            words_hash[word][:count] = words_hash[word][:count] + 1
            words_hash[word][:score] = words_hash[word][:score] + relevance
        end

        def get_word_relevances(words)
            normalized = {}

            # total_count = 0
            # words.each do |word, values|
            #     total_count = total_count + values[:count]
            # end

            words.each do |word, values|
                normalized[word] = values[:score].to_f*values[:count].to_f
            end

            max_score = normalized.max_by { |k, v| v }
            max_score = max_score[1]

            relevances = []

            normalized.each do |k, v|
                relevance = AI::Text::WordRelevance.new
                relevance.word = k
                relevance.relevance = v*100.0/max_score
                relevances << relevance
            end
            relevances
        end

		def analyse_batch(source_elements, query)

            results = algorithms[:textalytics].analyse_text_batch(source_elements, query)


            words = {}

            results.each do |result|

                analysis = result[:result]
                entities = analysis["entities"]
                categorization = analysis["categorization"]
                concepts = analysis["concepts"]


                entities.each do |entity|
                    word = entity["form"]
                    relevance = entity["relevance"]
                    update_scores(words, word, relevance)
                end

                concepts.each do |concept|
                    word = concept["form"]
                    relevance = concept["relevance"]
                    update_scores(words, word, relevance)
                end

                categorization.each do |category|
                    labels = category["labels"]
                    relevance = category["relevance"]
                    labels.each do |label|
                        update_scores(words, label, relevance)    
                    end                    
                end
            end

            
            relevances = get_word_relevances(words).sort_by { |w| -w.relevance }
        end

	end
end