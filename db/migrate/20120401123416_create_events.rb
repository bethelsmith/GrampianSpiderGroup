class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.date :date, :null =>false, :default => Date.today
      t.time :time, :null =>false,    :default => Time.now  
      t.string :location_name,  :null =>false, :limit => 100
      t.text :location_description
      t.string :grid_ref, :null =>false, :limit => 14
      t.text :event_description

      t.timestamps
    end
  end
end
