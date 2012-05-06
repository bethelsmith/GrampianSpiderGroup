class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.integer :user_id, :null =>false
      t.date :date, :null =>false
      t.string :species, :null =>false
      t.string :location, :null =>false, :limit => 100
      t.string :grid_ref, :null =>false, :limit => 14
      t.text :comments

      t.timestamps
    end
    add_index :records, [:user_id, :created_at]
  end
end
