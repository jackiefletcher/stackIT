require 'rails_helper'

describe Question do
    it { should validate_presence_of :ask }
    it { should have_many :responses }
    it { should belong_to :user }

    it "will have three responses when create with FactoryGirl" do
      question = FactoryGirl.create(:question_with_responses)
      expect(question.responses.length).to(eq(3))
    end

    describe "bestFirst" do
      it "will sort the questions responses putting the best first" do
        question = FactoryGirl.create(:question_with_responses)
        question.responses[1].answer = "Changed it"
        question.responses[1].best = true
        question.responses[1].save

        expect(question.reload.responses.first.answer).to(eq("Changed it"))
      end
    end
end
