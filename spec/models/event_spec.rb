require 'spec_helper'

describe Event do
  
  before(:each) do
    @attr = {
      :date => "20/04/2013",
      :time => "10:00",
      :location_name => "Location",
      :location_description => "This is the location description.",
      :grid_ref => "NJ40",
      :event_description => "This is the event description."
    }
  end
  
  it "should create a new instance given valid attributes" do
    Event.create!(@attr)
  end
  
  it "should require a date" do
    no_date_event = Event.new{@attr.merge(:date => "")}
    no_date_event.should_not be_valid
  end
  
  it "should require a time" do
    no_time_event = Event.new{@attr.merge(:time => "")}
    no_time_event.should_not be_valid
  end
  
  it "should require a location name" do
    no_location_name_event = Event.new{@attr.merge(:location_name => "")}
    no_location_name_event.should_not be_valid
  end
    
  it "should require a grid reference" do
    no_grid_ref_event = Event.new{@attr.merge(:grid_ref => "")}
    no_grid_ref_event.should_not be_valid
  end
  
  it "should reject location names that are too long" do
    long_location_name = "a" * 101
    long_location_name_event = Event.new{@attr.merge(:location_name => long_location_name)}
    long_location_name_event.should_not be_valid
  end
  
  it "should reject grid references that are too long" do
    long_grid_ref = "a" * 15
    long_grid_ref_event = Event.new{@attr.merge(:grid_ref => long_grid_ref)}
    long_grid_ref_event.should_not be_valid
  end
  
  it "should require a valid grid reference" do
    no_grid_ref_event = Event.new{@attr.merge(:grid_ref => "")}
    no_grid_ref_event.should_not be_valid
  end
  
  
  it "should accept valid grid references" do
    grids = %w[SH NP1234 OF1234567890]
    grids.each do |grid|
      valid_grid_ref_event = Event.new{@attr.merge(:grid_ref => grid)}
      valid_grid_ref_event.should be_valid
    end
  end
  
  it "should reject invalid grid references" do
    grids = %w[SH123 SH12D NI1234 1234]
    grids.each do |grid|
      invalid_grid_ref_event = Event.new{@attr.merge(:grid_ref => grid)}
      invalid_grid_ref_event.should_not be_valid
    end
  end
  
  describe "registrations" do
     
    before(:each) do
      @event = Event.create!(@attr)
      @user = Factory(:user)
    end
    
    it "should have a reverse_registrations method" do
      @event.should respond_to(:reverse_registrations)
    end
    
    it "should have an attendees method" do
      @event.should respond_to(:attendees)
    end
    
    
    
  end
end
