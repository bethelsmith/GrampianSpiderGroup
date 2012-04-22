class EventsRemoveDefaults < ActiveRecord::Migration
def self.up
    change_column_default(:events, :date, nil)
    change_column_default(:events, :time, nil)
end
end