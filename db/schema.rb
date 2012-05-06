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

ActiveRecord::Schema.define(:version => 20120503201549) do

  create_table "events", :force => true do |t|
    t.date     "date",                                :null => false
    t.time     "time",                                :null => false
    t.string   "location_name",        :limit => 100, :null => false
    t.text     "location_description"
    t.string   "grid_ref",             :limit => 14,  :null => false
    t.text     "event_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "records", :force => true do |t|
    t.integer  "user_id",                   :null => false
    t.date     "date",                      :null => false
    t.string   "species",                   :null => false
    t.string   "location",   :limit => 100, :null => false
    t.string   "grid_ref",   :limit => 14,  :null => false
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "records", ["user_id", "created_at"], :name => "index_records_on_user_id_and_created_at"

  create_table "registrations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "registrations", ["event_id"], :name => "index_registrations_on_event_id"
  add_index "registrations", ["user_id", "event_id"], :name => "index_registrations_on_user_id_and_event_id", :unique => true
  add_index "registrations", ["user_id"], :name => "index_registrations_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
