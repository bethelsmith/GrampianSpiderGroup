class UserMailer < ActionMailer::Base
  default :from => "notifications.gsg@gmail.com"
  
  def welcome_email(user)
    @user = user
    @url = "http://grampianspidergroup.com/login"
    mail(:to => user.email, :subject => "Welcome to the Grampian Spider Group")
  end
  
  def event_email(user, event)
    @user = user
    @event = event
    @url = "http://grampianspidergroup.com/event"
    mail(:to => user.email, :subject => "Grampian Spider Group Event")
  end
  
end
