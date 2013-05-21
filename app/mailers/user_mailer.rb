class UserMailer < ActionMailer::Base
  default from: "devnull@example.com"

  def todo_today(user)
  	@user = user
    mail(to: user.email, subject: "Todolist | Todos Today")
  end
end
