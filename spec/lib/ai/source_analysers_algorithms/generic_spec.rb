require 'rails_helper'

RSpec.describe AI::SourceAnalysersAlgorithms::Generic do

    let(:generic_algorithm) { AI::SourceAnalysersAlgorithms::Generic.new }
    describe :analyse_source do

    end

    describe :map_reduce do
        it "should return a valid hash" do
            content = "This is some some content"
            mapped = generic_algorithm.send(:map_reduce, content)
            expected = {
                "This" => 1,
                "is" => 1,
                "some" => 2,
                "content" => 1
            }
            expect(mapped).to eq(expected)
        end
    end

    describe :assign_score do
        it "should return correct score" do
            query = "some text"
            content = ""
            mapped = { 
                "some" => 10,
                "text" => 20 
            }
            score = generic_algorithm.send(:assign_score,
                content, mapped, query)
            expect(score).to be 30

        end
    end

    describe :length_factor do
        it "should return a number" do
            score = 1000
            length = 10
            expect(generic_algorithm.send(:length_factor, score, length)).to be > 0
        end
    end


end