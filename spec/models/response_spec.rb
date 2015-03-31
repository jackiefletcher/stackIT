require 'rails_helper'

describe Response do
  it { should validate_presence_of :answer }
  it { should belong_to :question }
  it { should belong_to :user }
  it { should have_many :votes }

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

  describe '#up_votes' do
    let(:user) { FactoryGirl.create(:user) }
    let!(:question) { FactoryGirl.create(:question, user_id: user.id) }
    let!(:response) { FactoryGirl.create(:response, user_id: user.id, question_id: question.id) }

    it "will return the amount of up_votes" do
      vote = FactoryGirl.create(:vote, voteable: response)
      vote2 = FactoryGirl.create(:vote, voteable: response, vote: true)
      expect(response.up_votes).to eq 1
    end
  end

  describe '#down_votes' do
    let(:user) { FactoryGirl.create(:user) }
    let!(:question) { FactoryGirl.create(:question, user_id: user.id) }
    let!(:response) { FactoryGirl.create(:response, user_id: user.id, question_id: question.id) }

    it "will return the amount of down_votes" do
      vote = FactoryGirl.create(:vote, voteable: response)
      vote2 = FactoryGirl.create(:vote, voteable: response, vote: true)
      expect(response.down_votes).to eq 1
    end
  end

  describe '#total_votes' do
    let(:user) { FactoryGirl.create(:user) }
    let!(:question) { FactoryGirl.create(:question, user_id: user.id) }
    let!(:response) { FactoryGirl.create(:response, user_id: user.id, question_id: question.id) }

    it "will return zero with no votes" do
      expect(response.total_votes).to eq 0
    end

    it "will add 1 with an upvote" do
      vote = FactoryGirl.create(:vote, voteable: response, vote: true)
      expect(response.total_votes).to eq 1
    end

    it "will take 1 away with a downvote" do
      vote = FactoryGirl.create(:vote, voteable: response)
      expect(response.total_votes).to eq -1
    end
  end
end
