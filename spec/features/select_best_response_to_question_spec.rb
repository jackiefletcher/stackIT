require 'rails_helper'

describe "the process of selecting a best response to a question" do

  it "will update best to true when clicked on profile page" do
    question_user = FactoryGirl.create(:user_with_questions)
    response_user1 = FactoryGirl.create(:user)
    response1 = FactoryGirl.create(:response, question_id: question_user.questions.first.id)
    response_user2 = FactoryGirl.create(:user)
    response2 = FactoryGirl.create(:response, question_id: question_user.questions.first.id)
    sign_in_user(question_user)
    visit user_path(question_user)
    click_on "response-id-#{response1.id}"
    expect(response1.reload.best).to be_truthy
  end

end
