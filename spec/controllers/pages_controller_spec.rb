require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'home'
      response.should have_selector("title",
                        :content => "Grampian Spider Group | Home")
      end
  end

  describe "GET 'contact'" do
    it "returns http success" do
      get 'contact'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'contact'
      response.should have_selector("title",
                        :content => "Grampian Spider Group | Contact")
      end
  end
  
  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'about'
      response.should have_selector("title",
                        :content => "Grampian Spider Group | About")
      end
  end
    
  describe "GET 'resources'" do
    it "returns http success" do
      get 'resources'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'resources'
      response.should have_selector("title",
                        :content => "Grampian Spider Group | Resources")
      end
  end

end
