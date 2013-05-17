# == Schema Information
#
# Table name: users
#
#  id                    :integer          not null, primary key
#  name                  :string(255)
#  email                 :string(255)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  password_digest       :string(255)
#  password              :string(255)
#  password_confirmation :string(255)
#  username              :string(255)
#  remember_token        :string(255)
#



require 'spec_helper'

describe User do

  before do
    @user = User.new(username: "exampleUser", name: "Example User", email: "user@example.com")
  end

  subject { @user }

  it { should respond_to(:username) }
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }  
  it { should respond_to(:admin) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:todos) } 
  it { should respond_to(:feed) }
  it { should respond_to(:relationships) }  
  it { should respond_to(:followed_users) }  

  it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  describe "when username is not present" do
    before { @user.username = " " }
    it { should_not be_valid }
  end
  describe "when username is too short" do
    before { @user.username = 'a' }
    it {should_not be_valid }
  end
  describe "when username is too long" do
    before { @user.username = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end
  describe "when name is too short" do
    before { @user.name = 'a' }
    it {should_not be_valid }
  end
  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end      
    end
  end
  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end      
    end
  end
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase      
      user_with_same_email.save
    end

    it { should_not be_valid }
  end


  describe "when password is not present" do
    before { @user.password = " " }
    it { should_not be_valid }
  end
  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end    
  describe "when password confirmation is not present" do
    before { @user.password_confirmation = " " }
    it { should_not be_valid }
  end
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end  

  describe "todo associations" do
    before { @user.save }
    # uses the let! method in place of let; 
    # let variables only spring into existence when referenced. 
    # 
    # The problem is that we want the todos to exist immediately, 
    # so that the timestamps are in the right order and so that @user.todos isn’t empty
    let!(:older_todo) do 
      FactoryGirl.create(:todo, user: @user, due_date: Date.today, created_at: 1.day.ago)
    end
    let!(:newer_todo) do
      FactoryGirl.create(:todo, user: @user, due.date: Date.tomorrow, created_at: 1.hour.ago)
    end
    it "should have the right todos in the reverse chronological order" do
      # This test also verifies the basic correctness of the has_many association itself, 
      # by checking that user.todos is an array of todos.
      @user.todos.should == [newer_todo, older_todo]
    end
    it "should destroy associated todos" do
      todos = @user.todos.dup
      @user.destroy
      todos.should_not be_empty
      todos.each do |toodo|
        Todo.find_by_id(todo.id).should be_nil
      end
    end

    describe "status" do
      let(:unfollowed_post) do
        FactoryGirl.create(:todo, user: FactoryGirl.create(:user))
      end

      its(:feed) { should include(newer_todo) }
      its(:feed) { should include(older_todo) }
      its(:feed) { should_not include(unfollowed_todo) }
    end
  end    
  describe "todo associations" do
    before { @user.save }
    let!(:older_todo) do 
      FactoryGirl.create(:todo, user: @user, due_date: Date.today, created_at: 1.day.ago)
    end
    let!(:newer_todo) do
      FactoryGirl.create(:todo, user: @user, due_date: Date.tomorrow, created_at: 1.hour.ago)
    end
    .
    .
    .
    describe "status" do
      let(:unfollowed_post) do
        FactoryGirl.create(:todo, user: FactoryGirl.create(:user))
      end
      let(:followed_user) { FactoryGirl.create(:user) }

      before do
        @user.follow!(followed_user)
        3.times { followed_user.todos.create!(content: "Lorem ipsum") }
      end

      its(:feed) { should include(newer_todo) }
      its(:feed) { should include(older_todo) }
      its(:feed) { should_not include(unfollowed_post) }
      its(:feed) do
        followed_user.todos.each do |todo|
          should include(todo)
        end
      end
    end
  end
end  
