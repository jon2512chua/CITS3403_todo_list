require 'spec_helper'

describe Todo do

  let(:user) { FactoryGirl.create(:user) }
  before do
    # This pattern is the canonical way to make a todo: 
    # through its association with a user. 
    # When a new todo is made in this way, 
    # its user_id is automatically set to the right value
    @todo = user.todos.build(content: "Lorem ipsum", due_date: Date.new(2013, 11, 2))
  end

  subject { @todo }

  it { should respond_to(:content) }
  it { should respond_to(:due_date) }
  it { should respond_to(:user_id) }
  # ensures that the correct user_id is associated to the Todo object
  its(:user_id) { should == user.id }

  it { should be_valid }

  describe "when content is not present" do
    before { @todo.content = ' ' }
    it { should_not be_valid }
  end
  describe "with content that is too long" do
    before { @todo.content = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when due_date is not present" do
    before { @todo.user_id = nil }
    it { should_not be_valid }
  end
  describe "when user_id is not present" do
    before { @todo.user_id = nil }
    it { should_not be_valid }
  end  

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      # This test verifies that calling Todo.new with a 
      # nonempty user_id raises a mass assignment security error exception. 
      expect do
        Todo.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end  
end