class AddLatLongToEventsAndRecords < ActiveRecord::Migration
  def change
    add_column :events, :latitude,  :float
    add_column :events, :longitude, :float
    add_column :records, :latitude,  :float
    add_column :records, :longitude, :float
  end
end
