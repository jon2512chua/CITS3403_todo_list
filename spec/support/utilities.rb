def full_title(page_title)
  base_title = "My Todos"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def sign_in(user)
  visit signin_path
  fill_in "Username",    with: user.username
  fill_in "Password", with: user.password
  click_button "Sign in"
  cookies[:remember_token] = user.remember_token
end

# Enables us to do things such as: should have_error_message('Invalid')
RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div#error_explanation', text: message)
  end
end