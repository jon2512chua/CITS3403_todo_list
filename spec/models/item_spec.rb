require 'spec_helper'

describe Item do

  let(:user) { FactoryGirl.create(:user) }
  before do
    @item = user.items.build(name: "Item 1", content: "Item description 1")
  end

  subject { @item }

  it { should respond_to(:name) }
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @item.user_id = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Item.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
end
