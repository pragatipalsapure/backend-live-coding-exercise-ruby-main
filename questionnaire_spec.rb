require_relative "questionnaire"

RSpec.describe "Questionnaire Survey" do
  before(:each) do
    @store = PStore.new("test_store.pstore")
    @store.transaction do
      @store[:answers] = {}
    end
  end

  describe "#do_prompt" do
    it "should prompt the user for responses to all questions" do
      allow_any_instance_of(Object).to receive(:gets).and_return("yes", "yes", "no", "yes", "no")
      expect { do_prompt(@store) }.to output(/Your rating for this run/).to_stdout
    end
  end

  describe "#calculate_rating" do
    it "should calculate the rating based on the number of 'yes' answers" do
      expect(calculate_rating(3)).to eq(60.0)
    end

    it "should return 0 if the total number of questions is zero" do
      expect(calculate_rating(0)).to eq(0)
    end
  end

  describe "#do_report" do
    it "should calculate and report the average rating for all runs" do
      @store.transaction do
        @store[:answers] = { "q1" => "yes", "q2" => "yes", "q3" => "no",  "q4" => "no",  "q5" => "no" }
      end
      expect { do_report(@store, 2) }.to output(/Average rating for all runs: 8.0%/).to_stdout
    end
  end
end
