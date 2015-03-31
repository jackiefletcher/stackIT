require 'rails_helper'

feature 'user interacting with response votes' do
  let(:alice) { FactoryGirl.create(:user) }
  let(:bob) { FactoryGirl.create(:user) }
  let(:question) { FactoryGirl.create(:question, user_id: alice.id) }
  let!(:response) { FactoryGirl.create(:response, user_id: bob.id, question_id: question.id) }

  scenario 'the vote count starts at 0' do
    visit question_path(question)
    expect(page).to have_content '0'
  end

  scenario 'the user up-votes a response' do
    log_in_user
    visit question_path(question)
    click_link "#{response.id}-upvote"
    expect(page).to have_content '1'
  end
end


def log_in_user
  user = FactoryGirl.create(:user)
  visit '/'
  click_on "Login"
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_on "Login"
end
