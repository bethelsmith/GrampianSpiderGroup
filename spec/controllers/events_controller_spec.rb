require 'spec_helper'

describe EventsController do
  render_views
  
   describe "GET 'index'" do
     
    describe "for non-signed-in users" do
      
      it "should deny access" do
        get :index
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
      
    end
    
    describe "for signed-in users" do
    
      before(:each) do
        @user = test_sign_in(FactoryGirl.create(:user))
        @event = FactoryGirl.create(:event)
        @events = [@event]
        30.times do
          @events << FactoryGirl.create(:event)
        end
      end

      it "should be successful" do
        get :index
        response.should be_success
      end

      it "should have the right title" do
        get :index
        response.should have_selector("title", :content => "All Events")
      end

      it "should have an element for each event" do
        get :index
        @events[0..2].each do |event|
          response.should have_selector("li", :content => event.title)
        end
      end

      it "should paginate events" do
        get :index
        response.should have_selector("div.pagination")
        response.should have_selector("span.disabled", :content => "Previous")
        response.should have_selector("a", :href => "/events?page=2",
                                           :content => "2")
        response.should have_selector("a", :href => "/events?page=2",
                                           :content => "Next")
      end
    end
  end
   
  describe "GET 'new'" do
     
    before(:each) do
      @event = FactoryGirl.create(:event)
    end 
     
      describe "for non-admin users" do
        
      end
      
      describe "for admin users" do
        
        before(:each) do
          admin = FactoryGirl.create(:user, :email => "admin@example.com", :admin => true)
          test_sign_in(admin)
        end
        
        it "returns http success" do
          get 'new'
          response.should be_success
        end
    
        it "should have the right title" do
          get 'new'
          response.should have_selector("title", :content => "New Event")
        end
      end
  end


  
  describe "GET 'show'" do

    before(:each) do
      @event = FactoryGirl.create(:event)
    end

    it "should be successful" do
      get :show, :id => @event
      response.should be_success
    end

  
    it "should have the right title" do
      get :show, :id => @event
      response.should have_selector("title", :content => @event.location_name)
    end
    
    it "should have the right attendee counts" do
      response.should have_selector("a", :href => attendees_event_path(@event),
                                         :content => "0 attendees")
    end
    
  end
  
  
   describe "POST 'create'" do

    describe "failure" do
  
      before(:each) do
        @attr = { :date => "", :time => "", :location_name => "",
                  :grid_ref => "" }
      end

      it "should not create an event" do
        lambda do
          post :create, :event => @attr
        end.should_not change(Event, :count)
      end

      it "should render the 'new' page" do
        post :create, :event => @attr
        response.should render_template('new')
      end
    end
    
    describe "success" do

      before(:each) do
        @attr = { :date => Date.today, :time => "10:00", :location_name => "test location",
                  :grid_ref => "NJ40" }
      end

      it "should create an event" do
        lambda do
          post :create, :event => @attr
        end.should change(Event, :count).by(1)
      end

      it "should redirect to the event show page" do
        post :create, :event=> @attr
        response.should redirect_to(event_path(assigns(:event)))
      end
    
    end
  end
   
  describe "GET 'edit'" do

    before(:each) do
      admin = FactoryGirl.create(:user, :email => "admin@example.com", :admin => true)
      test_sign_in(admin)
      @event = FactoryGirl.create(:event)
    end

    it "should be successful" do
      get :edit, :id => @event
      response.should be_success
    end

    it "should have the right title" do
      get :edit, :id => @event
      response.should have_selector("title", :content => "Edit Event")
    end
  end
   
  describe "PUT 'update'" do

    before(:each) do
      admin = FactoryGirl.create(:user, :email => "admin@example.com", :admin => true)
      test_sign_in(admin)
      @event = FactoryGirl.create(:event)
    end

    describe "failure" do

      before(:each) do
        @attr = { :date => "", :time => "", :location_name => "",
                  :grid_ref => "" }
      end

      it "should render the 'edit' page" do
        put :update, :id => @event, :event => @attr
        response.should render_template('edit')
      end

      it "should have the right title" do
        put :update, :id => @event, :event => @attr
        response.should have_selector("title", :content => "Edit Event")
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :date => Date.today, :time => "10:00", :location_name => "Test location name",
                  :grid_ref => "NJ40" }
      end

      it "should change the event's attributes" do
        put :update, :id => @event, :event => @attr
        @event.reload
        @event.date.should  == @attr[:date]
        @event.location_name.should == @attr[:location_name]
        @event.grid_ref.should == @attr[:grid_ref]
      end

      it "should redirect to the event show page" do
        put :update, :id => @event, :event => @attr
        response.should redirect_to(event_path(@event))
      end

      it "should have a flash message" do
        put :update, :id => @event, :event => @attr
        flash[:success].should =~ /updated/
      end
    end
  end
  
  describe "authentication of new/edit/update pages" do

    before(:each) do
      @event = FactoryGirl.create(:event)
    end

    describe "for non-signed-in users" do
      
      it "should deny access to 'new'" do
        get :new, :id => @event
        response.should redirect_to(signin_path)
      end

      it "should deny access to 'edit'" do
        get :edit, :id => @event
        response.should redirect_to(signin_path)
      end

      it "should deny access to 'update'" do
        put :update, :id => @event, :user => {}
        response.should redirect_to(signin_path)
      end
    end
  end
  
  describe "DELETE 'destroy'" do

    before(:each) do
      @event = FactoryGirl.create(:event)
      @user = FactoryGirl.create(:user)
    end

    describe "as a non-signed-in user" do
      it "should deny access" do
        delete :destroy, :id => @event
        response.should redirect_to(signin_path)
      end
    end

    describe "as a non-admin user" do
      it "should protect the page" do
        test_sign_in(@user)
        delete :destroy, :id => @event
        response.should redirect_to(root_path)
      end
    end

    describe "as an admin user" do

      before(:each) do
        admin = FactoryGirl.create(:user, :email => "admin@example.com", :admin => true)
        test_sign_in(admin)
        @event = FactoryGirl.create(:event)
      end

      it "should destroy the event" do
        lambda do
          delete :destroy, :id => @event
        end.should change(Event, :count).by(-1)
      end

      it "should redirect to the events page" do
        delete :destroy, :id => @event
        response.should redirect_to(events_path)
      end
    end
  end
  
  describe "attendee pages" do

    describe "when not signed in" do

      it "should protect 'attendees'" do
        get :attendees, :id => 1
        response.should redirect_to(signin_path)
      end
    end
    
    describe "when signed in" do

      before(:each) do
        @user = test_sign_in(FactoryGirl.create(:user))
        @event = FactoryGirl.create(:event)
        @user.attend!(@event)
      end

      it "should show event attendees" do
        get :attendees, :id => @event
        response.should have_selector("a", :href => event_path(@user),
                                           :content => @user.name)
      end
    end
  end
   
end









