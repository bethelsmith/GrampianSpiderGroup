require 'spec_helper'

describe "events/new" do
  before(:each) do
    assign(:event, stub_model(Event,
      :location_name => "MyText",
      :location_description => "MyText",
      :grid_ref => "MyText",
      :easting => 1.5,
      :northing => 1.5,
      :event_description => "MyText"
    ).as_new_record)
  end

  it "renders new event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => events_path, :method => "post" do
      assert_select "textarea#event_location_name", :name => "event[location_name]"
      assert_select "textarea#event_location_description", :name => "event[location_description]"
      assert_select "textarea#event_grid_ref", :name => "event[grid_ref]"
      assert_select "input#event_easting", :name => "event[easting]"
      assert_select "input#event_northing", :name => "event[northing]"
      assert_select "textarea#event_event_description", :name => "event[event_description]"
    end
  end
end
