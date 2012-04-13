require 'spec_helper'

describe "LayoutLinks" do
    
    it "should have a Home page at '/'" do
      get '/'
      response.should have_selector('title', :content => "Home")
    end
  
    it "should have a Contact page at '/contact'" do
      get '/contact'
      response.should have_selector('title', :content => "Contact")
    end

    it "should have an About page at '/about'" do
      get '/about'
      response.should have_selector('title', :content => "About")
    end
    
    it "should have a Resources page at '/resources'" do
      get '/resources'
      response.should have_selector('title', :content => "Resources")
    end
end

