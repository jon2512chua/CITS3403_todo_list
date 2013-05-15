require 'spec_helper'

describe "Static pages" do
	let(:base_title) { "My Todos" }

  describe "Home page" do
		before { visit root_path }
    it "should have the h1 'My Todos'" do
      page.should have_selector('h1', :text => 'My Todos')
    end
    it "should have the title 'Home'" do
      page.should have_selector('title',
                        :text => "#{base_title} | Home")
    end    
  end

  describe "Help page" do
  	before { visit help_path }
    it "should have the h1 'Help'" do
      page.should have_selector('h1', :text => 'Help')
    end
    it "should have the title 'Help'" do
      page.should have_selector('title',
                        :text => "#{base_title} | Help")
    end        
  end  

  describe "About page" do
  	before { visit about_path }
    it "should have the h1 'About'" do
      page.should have_selector('h1', :text => 'About')
    end
    it "should have the title 'About'" do
      page.should have_selector('title',
                        :text => "#{base_title} | About")
    end        
  end    
end