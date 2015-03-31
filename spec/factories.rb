FactoryGirl.define do

  factory(:response) do
    answer('Be yourself!')
    question
  end

  factory(:question) do
    ask('How to be awesome?')
    user

    factory :question_with_responses do
      transient do
        responses_count 3
      end

      after(:create) do |question, evaluator|
        create_list(:response, evaluator.responses_count, question: question)
      end
    end
  end


  factory(:user) do
    email('test@test.com')
    password('12345')

    factory :user_with_questions do
      transient do
        questions_count 3
      end

      after(:create) do |user, evaluator|
        create_list(:question, evaluator.questions_count, user: user)
      end
    end
  end

  factory(:vote) do
    vote(false)
    user_id(2)
  end


end
