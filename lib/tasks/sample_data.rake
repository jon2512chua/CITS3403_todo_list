namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Admin User",
                         username: "adminuser",
                         email: "3403todolist@gmail.com",
                         password: "todolist3403",
                         password_confirmation: "todolist3403")
    admin.toggle!(:admin)
    99.times do |n|
      name  = "#{Faker::Name.first_name} #{Faker::Name.last_name}"
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
