FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "person#{n}" }
    sequence(:name)     { |n| "Person #{n}" }
    sequence(:email)    { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :item do
    name "Item 1"
    content "Item description 1"
    user
  end
end
