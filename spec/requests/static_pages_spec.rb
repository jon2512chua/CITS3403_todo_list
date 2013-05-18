require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_selector('title', text: full_title('')) }
    it { should_not have_selector('title', text: '| Home')}
  end

  describe "User home page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:item, user: user, content: "Foo") }
    let!(:m2) { FactoryGirl.create(:item, user: user, content: "Bar") }
    before do
      sign_in user
      visit root_path
    end

    it { should have_selector('title', text: user.name) }

    describe "items" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.items.count) }
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

  describe "Sitemap page" do
    before { visit sitemap_path }

    it { should have_selector('h1',    text: 'Sitemap') }
    it { should have_selector('title', text: full_title('Sitemap')) }
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1',    text: 'Sign up') }
    it { should have_selector('title', text: 'Sign up') }
  end
end