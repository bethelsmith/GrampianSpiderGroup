class AddIndexToRegistrations < ActiveRecord::Migration
  def change
    add_index :registrations, :user_id
    add_index :registrations, :event_id
    add_index :registrations, [:user_id, :event_id], :unique => true
  end
end
