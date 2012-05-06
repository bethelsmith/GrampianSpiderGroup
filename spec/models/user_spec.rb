require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = {
      :name => "Example User",
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end
  
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end
  
  it "should require a name" do
    no_name_user = User.new{@attr.merge(:name => "")}
    no_name_user.should_not be_valid
  end
  
  it "should require an email address" do
    no_email_user = User.new{@attr.merge(:email => "")}
    no_email_user.should_not be_valid
  end
    
  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = User.new{@attr.merge(:name => long_name)}
    long_name_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    addresses =%w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new{@attr.merge(:email => address)}
      invalid_email_user.should_not be_valid
    end
  end
    
  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  describe "password validations" do

    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
      should_not be_valid
    end
  
    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
      should_not be_valid
    end
  
    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end
  
    it "should reject long passwords" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end
  
  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end
  
    describe "has_password? method" do

      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end    
    
      it "should be false if the passwords don't match" do
        @user.has_password?("invalid").should be_false
      end
    end
    
        describe "authenticate method" do

      it "should return nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_password_user.should be_nil
      end

      it "should return nil for an email address with no user" do
        nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
        nonexistent_user.should be_nil
      end

      it "should return the user on email/password match" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        matching_user.should == @user
      end
    end
  end
  
  describe "admin attribute" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should respond to admin" do
      @user.should respond_to(:admin)
    end

    it "should not be an admin by default" do
      @user.should_not be_admin
    end

    it "should be convertible to an admin" do
      @user.toggle!(:admin)
      @user.should be_admin
    end
  end
  
  describe "record associations" do
    
    before(:each) do
      @user = FactoryGirl.create(:user)
      @record1 = FactoryGirl.create(:record, :user => @user, :created_at => 1.day.ago)
      @record2 = FactoryGirl.create(:record, :user => @user, :created_at => 1.hour.ago)
    end
    
    it "should have a records attribute" do
      @user.should respond_to(:records)
    end

    it "should have the right records in the right order" do
      @user.records.should == [@record2, @record1]
    end
    
    it "should destroy associated records" do
      @user.destroy
      [@record1, @record2].each do |record|
        Record.find_by_id(record.id).should be_nil
      end
    end
    
  end
  
  describe "registrations" do
    
    before(:each) do
      @user = User.create!(@attr)
      @event = FactoryGirl.create(:event)
    end
    
    it "should have a regristrations method" do
      @user.should respond_to(:registrations)
    end
    
    it "should have an attending method" do
      @user.should respond_to(:attending)
    end
    
    it "should have an attending? method" do
      @user.should respond_to(:attending?)
    end
    
    it "should have an attend! method" do
      @user.should respond_to(:attend!)
    end
    
    it "should attend an event" do
      @user.attend!(@event)
      @user.should be_attending(@event)
    end
    
    it "should include the event in the attending array" do
      @user.attend!(@event)
      @user.attending.should include(@event)
    end
    
    it "should have an unattend! method" do
      @user.should respond_to(:unattend!)
    end
    
    it "should unattend an event" do
      @user.attend!(@event)
      @user.unattend!(@event)
      @user.should_not be_attending(@event)
    end
    
  end
end
