require 'spec_helper'

describe RegistrationsController do

  describe "access control" do

    it "should require signin for create" do
      post :create
      response.should redirect_to(signin_path)
    end

    it "should require signin for destroy" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end

  describe "POST 'create'" do

    before(:each) do
      @user = test_sign_in(FactoryGirl.create(:user))
      @event = FactoryGirl.create(:event)
    end

    it "should create a registration" do
      lambda do
        post :create, :registration => { :user_id => @user }
        response.should be_redirect
      end.should change(Registration, :count).by(1)
    end
  
    it "should create a registration using Ajax" do
      lambda do
        xhr :post, :create, :registration => { :user_id => @user }
        response.should be_success
      end.should change(Registration, :count).by(1)
    end
  end

  describe "DELETE 'destroy'" do

    before(:each) do
      @user = test_sign_in(FactoryGirl.create(:user))
      @event = FactoryGirl.create(:event)
      @user.attend!(@event)
      @registration = @user.registrations.find_by_event_id(@event)
    end

    it "should destroy a registration" do
      lambda do
        delete :destroy, :id => @registration
        response.should be_redirect
      end.should change(Registration, :count).by(-1)
    end
    
    it "should destroy a registration using Ajax" do
      lambda do
        xhr :delete, :destroy, :id => @registration
        response.should be_success
      end.should change(Registration, :count).by(-1)
    end
    
  end
end