class RegistrationsController < ApplicationController
  before_filter :authenticate

  def create
    @event = Event.find(params[:registration][:user_id])
    current_user.attend!(@event)
    respond_to do |format|
      format.html { redirect_to @event }
      format.js
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @user = Registration.find(params[:id]).user
    current_user.unattend!(@user)
    respond_to do |format|
      format.html { redirect_to @event }
      format.js
    end
  end
  
  def authenticate
    deny_access unless signed_in?
  end
  
end