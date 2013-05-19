require 'spec_helper'

describe "Item pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "item creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a item" do
        expect { click_button "Post" }.not_to change(Item, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'item_content', with: "Item description" }
      before { fill_in 'item_name', with: "Item name" }
      it "should create a item" do
        expect { click_button "Post" }.to change(Item, :count).by(1)
      end
    end
  end

  describe "item destruction" do
    before { FactoryGirl.create(:item, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete an item" do
        expect { click_link "X" }.to change(Item, :count).by(-1)
      end
    end
  end
end