require 'spec_helper'

describe RecordsController do
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
        @recorder = FactoryGirl.create(:user)
        @record = FactoryGirl.create(:record)
        @records = [@record]
        30.times do
          @records << FactoryGirl.create(:record, :user => @recorder)
        end
      end

      it "should be successful" do
        get :index
        response.should be_success
      end

      it "should have the right title" do
        get :index
        response.should have_selector("title", :content => "All Records")
      end
    end
  end
   
  describe "GET 'new'" do
     
    before(:each) do
      @user = test_sign_in(FactoryGirl.create(:user))
    end 

    it "returns http success" do
      get 'new'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "New Record")
    end
  end
  
  describe "GET 'show'" do

    before(:each) do
      @recorder = FactoryGirl.create(:user)
      @record = FactoryGirl.create(:record, :user => @recorder)
    end

    it "should be successful" do
      get :show, :id => @record
      response.should be_success
    end

  
    it "should have the right title" do
      get :show, :id => @record
      response.should have_selector("title", :content => @record.title)
    end
  end
  
  describe "POST 'create'" do
  
    before(:each) do
      @user = test_sign_in(FactoryGirl.create(:user))
    end 

    describe "failure" do
  
      before(:each) do
        @attr = {
          :date => "",
          :species => "",
          :location => "",
          :grid_ref => "",
          :latitude => "",
          :longitude => ""
        }
      end

      it "should not create a record" do
        lambda do
          post :create, :record => @attr
        end.should_not change(Record, :count)
      end

      it "should render the 'new' page" do
        post :create, :record => @attr
        response.should render_template('new')
      end
    end
    
    describe "success" do

      before(:each) do
        @attr = {
          :date => Date.today,
          :species => "Arianella cucurbitina",
          :location => "Aberdeenshire",
          :grid_ref => "NJ40",
          :latitude => "57.087070",
          :longitude => "-2.991625"
        }
      end

      it "should create a record" do
        lambda do
          post :create, :record => @attr
        end.should change(Record, :count).by(1)
      end

      it "should redirect to the record show page" do
        post :create, :record => @attr
        response.should redirect_to(record_path(assigns(:record)))
      end
    
    end
  end
  
  describe "GET 'edit'" do

    before(:each) do
      @user = test_sign_in(FactoryGirl.create(:user))
      @record = FactoryGirl.create(:record, :user => @user)
    end

    it "should be successful" do
      get :edit, :id => @record
      response.should be_success
    end

    it "should have the right title" do
      get :edit, :id => @record
      response.should have_selector("title", :content => "Edit Record")
    end
  end
  
  describe "PUT 'update'" do

    before(:each) do
      @user = test_sign_in(FactoryGirl.create(:user))
      @record = FactoryGirl.create(:record, :user => @user)
    end

    describe "failure" do

      before(:each) do
        @attr = {
          :date => "",
          :species => "",
          :location => "",
          :grid_ref => ""
        }
      
      end

      it "should render the 'edit' page" do
        put :update, :id => @record, :record => @attr
        response.should render_template('edit')
      end

      it "should have the right title" do
        put :update, :id => @record, :record => @attr
        response.should have_selector("title", :content => "Edit Record")
      end
    end

    describe "success" do

      before(:each) do
        @attr = {
          :date => Date.today,
          :species => "Arianella cucurbitina",
          :location => "Aberdeenshire",
          :grid_ref => "NJ40",
          :latitude => "57.087070",
          :longitude => "-2.991625"
        }
      end

      it "should change the user's attributes" do
        put :update, :id => @record, :record => @attr
        @record.reload
        @record.date.should  == @attr[:date]
        @record.species.should  == @attr[:species]
        @record.location.should  == @attr[:location]
        @record.grid_ref.should  == @attr[:grid_ref]
      end

      it "should redirect to the user show page" do
        put :update, :id => @record, :record => @attr
        response.should redirect_to(record_path(@record))
      end

      it "should have a flash message" do
        put :update, :id => @record, :record => @attr
        flash[:success].should =~ /updated/
      end
    end
  end
  
  describe "authentication of new/edit/update pages" do

    before(:each) do
      @user = FactoryGirl.create(:user)
      @record = FactoryGirl.create(:record, :user => @user)
    end

    describe "for non-signed-in users" do

      it "should deny access to 'edit'" do
        get :edit, :id => @record
        response.should redirect_to(signin_path)
      end

      it "should deny access to 'update'" do
        put :update, :id => @record, :user => {}
        response.should redirect_to(signin_path)
      end
    end
  end
  
  describe "DELETE 'destroy'" do

    before(:each) do
      @user = FactoryGirl.create(:user)
      @record = FactoryGirl.create(:record, :user => @user)
    end

    describe "as a non-signed-in user" do
      
      it "should deny access" do
        delete :destroy, :id => @record
        response.should redirect_to(signin_path)
      end
    end

    describe "as the correct user" do

      before(:each) do
        admin = FactoryGirl.create(:user, :email => "admin@example.com", :admin => true)
        test_sign_in(admin)
        @record = FactoryGirl.create(:record, :user => admin)
      end

      it "should destroy the record" do
        lambda do
          delete :destroy, :id => @record
        end.should change(Record, :count).by(-1)
      end

      it "should redirect to the records page" do
        delete :destroy, :id => @record
        response.should redirect_to(records_path)
      end
    end
  end
  
end