FactoryGirl.define do
  factory :user do
    username 'NewUser'
    email 'email@email.com'
    password 'tester12'
    password_confirmation 'tester12'
  end

  factory :marathon do
    state_id 1
    city 'Trenton'
    time '4000'
    user
  end
end
