require "spec_helper"

describe UserMailer do
  
  describe 'welcome email' do
    
    before(:each) do
      @user = FactoryGirl.create(:user)
      @mail = UserMailer.welcome_email(@user)
    end
    
    it 'renders the subject' do
      @mail.subject.should == "Welcome to the Grampian Spider Group"
    end
 
    it 'renders the receiver email' do
      @mail.to.should == [@user.email]
    end
 
    it 'renders the sender email' do
      @mail.from.should == ['notifications.gsg@gmail.com']
    end

    it 'assigns @name' do
      @mail.body.encoded.should match(@user.name)
    end
    
  end
  
    describe 'event email' do
    
    before(:each) do
    @user = FactoryGirl.create(:user)
    @event = FactoryGirl.create(:event)
    @user.attend!(@event)
    @mail = UserMailer.event_email(@user, @event)
    end
    
    it 'renders the subject' do
      @mail.subject.should == "Grampian Spider Group Event"
    end
 
    it 'renders the receiver email' do
      @mail.to.should == [@user.email]
    end
 
    it 'renders the sender email' do
      @mail.from.should == ['notifications.gsg@gmail.com']
    end

    it 'assigns title' do
      @mail.body.encoded.should match(@event.title)
    end
    
    it 'assigns location name' do
      @mail.body.encoded.should match(@event.location_name)
    end

  end
  
end
