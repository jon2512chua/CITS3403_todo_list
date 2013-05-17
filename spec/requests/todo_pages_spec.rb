require 'spec_helper'

describe "Todo pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "todo creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a todo" do
        expect { click_button "Let's Do This" }.not_to change(Todo, :count)
      end

      describe "error messages" do
        before { click_button "Let's Do This" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do

      before { fill_in 'todo_content', with: "Lorem ipsum" }
      it "should create a todo" do
        expect { click_button "Let's Do This" }.to change(Todo, :count).by(1)
      end
    end
  end
  describe "todo destruction" do
    before { FactoryGirl.create(:todo, user: user, due_date: Date.today) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a todo" do
        # uses Capybara to click the “delete” link and 
        # expects the Todo count to decrease by 1
        expect { click_link "delete" }.to change(Todo, :count).by(-1)
      end
    end
  end  
end