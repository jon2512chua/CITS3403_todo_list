require 'spec_helper'
# full_path defined in spec/support/utilities.rb

describe "Static pages" do
  it "should have the right links on the layout" do
    visit root_path?

    click_link "About"
    page.should have_selector 'title', text: full_title('About')
    click_link "Help"
    page.should have_selector 'title', text: full_title('Help')
    click_link "Home"
    click_link "Sign up now!"
    page.should have_selector 'title', text: full_title('Sign up')
    click_link "My Todos"
    page.should have_selector 'title', text: full_title('Home')
    click_link "Sign in"
    page.should have_selector 'title', text: full_title('Sign in')
  end

  describe "Home page" do
		before { visit root_path }

    it { should have_selector('h1',    text: 'My Todos') }
    it { should_not have_selector 'title', text: full_title('Home') }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:todo, user: user, content: "Lorem ipsum", due_date: Date.today)
        FactoryGirl.create(:todo, user: user, content: "Dolor sit amet", due_date: Date.tomorrow)
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          # the first # in li##{item.id} is Capybara syntax for a CSS id, 
          # the second # is the beginning of a Ruby string interpolation #{}
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end
    end    
  end

  describe "Help page" do
  	before { visit help_path }

    it { should have_selector('h1',    text: 'Help') }
    it { should have_selector('title', text: full_title('Help')) }  
  end  

  describe "About page" do
  	before { visit about_path }

    it { should have_selector('h1',    text: 'About') }
    it { should have_selector('title', text: full_title('About')) }
  end
end