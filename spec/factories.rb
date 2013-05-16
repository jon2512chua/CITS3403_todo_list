  FactoryGirl.define do
    factory :user do
    	username "m_hartl"
      name     "Michael Hartl"
      email    "michael@example.com"
      password "foobar"
      password_confirmation "foobar"
    end
  end