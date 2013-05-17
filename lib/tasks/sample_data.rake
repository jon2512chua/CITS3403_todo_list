namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    require 'populator'
   
    admin = User.create!(username: "exampleUser",
                         name: "Example User",
                         email: "example@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar")
    admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(username: username,
                   name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(2)
      users.each { |user| user.todos.create!(content: content, due_date: Date.tomorrow) }
    end    
  end
end