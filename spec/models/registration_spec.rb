require 'spec_helper'

describe Registration do
  
  before(:each) do
    @user = Factory(:user)
    @event = Factory(:event)
    
    @registration = @user.registrations.build(:event_id => @event.id)
  end
  
  it "should create a new instance given valid attibutes" do
    @registration.save!
  end
  
  describe "attend event methods" do
    
    before(:each) do
      @registration.save
    end
    
    it "should have an event attribute" do
      @registration.should respond_to(:event)
    end
    
    it "should have the right event" do
      @registration.event.should == @event
    end
    
     it "should have an user attribute" do
      @registration.should respond_to(:user)
    end
    
    it "should have the right user" do
      @registration.user.should == @user
    end
  end
  
  describe "validations" do
    
    it "should require a user_id" do
      @registration.user_id = nil
      @registration.should_not be_valid
    end
    
    it "should require an event_id" do
      @registration.event_id = nil
      @registration.should_not be_valid
    end
    
  end
  
end
