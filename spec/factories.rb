FactoryGirl.define do
  factory :user do
  	sequence(:username) { |n| "person_#{n}" }  	
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end
end

  # FactoryGirl.define do
  #   factory :user do
  #   	username "m_hartl"
  #     name     "Michael Hartl"
  #     email    "michael@example.com"
  #     password "foobar"
  #     password_confirmation "foobar"
  #   end
  # end