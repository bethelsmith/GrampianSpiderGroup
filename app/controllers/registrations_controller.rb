class RegistrationsController < ApplicationController
  before_filter :authenticate

  def create
    @event = Event.find(params[:registration][:user_id])
    current_user.attend!(@event)
    redirect_to @event 
  end

  def destroy
    @event = Event.find(params[:id])
    @user = Registration.find(params[:id]).user
    current_user.unattend!(@user)
    redirect_to @event
  end
  
  def authenticate
    deny_access unless signed_in?
  end
  
end