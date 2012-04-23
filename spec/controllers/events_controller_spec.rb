require 'spec_helper'

describe EventsController do
  render_views
  
  describe "GET 'new'" do
    
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it"should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "New Event")
    end
  end
  
  describe "GET 'show'" do
    before(:each) do
      @event = Factory(:event)
    end
    
    it "should be successful" do
      get :show, :id => @event
      response.should be_success
    end

    it "should find the right event" do
      get :show, :id => @event
      assigns(:event).should == @event
    end

  
    it "should have the right title" do
      get :show, :id => @event
      response.should have_selector("title", :content => @event.location_name)
    end
  end
  
  describe "GET 'index'" do
    before(:each) do
      @event = Factory(:event)
    end
    
    it "should be successful" do
      get :index
      response.should be_success
    end
    
    it "should have the right title" do
      get :index
      response.should have_selector("title", :content => "All Events")
    end
    
  end

end
