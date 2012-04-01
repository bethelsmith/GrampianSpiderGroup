require 'spec_helper'

describe "events/edit" do
  before(:each) do
    @event = assign(:event, stub_model(Event,
      :location_name => "MyText",
      :location_description => "MyText",
      :grid_ref => "MyText",
      :easting => 1.5,
      :northing => 1.5,
      :event_description => "MyText"
    ))
  end

  it "renders the edit event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => events_path(@event), :method => "post" do
      assert_select "textarea#event_location_name", :name => "event[location_name]"
      assert_select "textarea#event_location_description", :name => "event[location_description]"
      assert_select "textarea#event_grid_ref", :name => "event[grid_ref]"
      assert_select "input#event_easting", :name => "event[easting]"
      assert_select "input#event_northing", :name => "event[northing]"
      assert_select "textarea#event_event_description", :name => "event[event_description]"
    end
  end
end
