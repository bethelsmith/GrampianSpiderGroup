# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120401123416) do

  create_table "events", :force => true do |t|
    t.date     "date",                                :default => '2012-04-01',          :null => false
    t.time     "time",                                :default => '2000-01-01 13:05:10', :null => false
    t.string   "location_name",        :limit => 100,                                    :null => false
    t.text     "location_description"
    t.string   "grid_ref",             :limit => 14,                                     :null => false
    t.float    "easting"
    t.float    "northing"
    t.text     "event_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
