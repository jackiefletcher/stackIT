require 'rails_helper'

describe Response do
  it { should validate_presence_of :answer }
  it { should belong_to :question }
  it { should belong_to :user }

  it "will default best property to false when created" do
    test_r = FactoryGirl.create(:response)
    expect(test_r.best).to(eq(false))
  end

  describe 'default scope' do
    let(:user) { FactoryGirl.create(:user) }
    let!(:question) { FactoryGirl.create(:question, user_id: user.id) }
    let!(:response) { FactoryGirl.create(:response, user_id: user.id, question_id: question.id) }
    let!(:response_two) { FactoryGirl.create(:response, user_id: user.id, question_id: question.id, best: true) }
    let!(:response_three) { FactoryGirl.create(:response, user_id: user.id, question_id: question.id) }

    it "should place the 'best' answer first" do
      expect(question.responses[0]).to eq response_two
    end
  end
end
