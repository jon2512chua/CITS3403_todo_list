namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Example User",
                         username: "exampleuser",
                         email: "example@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar")
    admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      username = name.split.join.downcase
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   username: username,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    users = User.all(limit: 6)
    10.times do
      name = Faker::Lorem.words(1)
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.items.create!(name: name, content: content) }
    end
  end
end
