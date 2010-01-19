# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100104163632) do

  create_table "bandpictures", :force => true do |t|
    t.string   "original"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "band_id"
    t.string   "large"
    t.string   "largesquare"
    t.string   "medium"
    t.string   "small"
  end

  create_table "bands", :force => true do |t|
    t.string "band_name"
  end

  create_table "bands_shows", :id => false, :force => true do |t|
    t.integer "show_id"
    t.integer "band_id"
  end

  add_index "bands_shows", ["band_id"], :name => "index_bands_shows_on_band_id"
  add_index "bands_shows", ["show_id", "band_id"], :name => "index_bands_shows_on_show_id_and_band_id", :unique => true

  create_table "comments", :force => true do |t|
    t.text     "user_comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "show_id"
    t.integer  "user_id"
  end

  create_table "locations", :force => true do |t|
    t.string "city"
    t.string "state"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "shows", :force => true do |t|
    t.date     "date"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price"
    t.time     "showtime"
    t.integer  "attending",                                  :default => 0
    t.string   "time"
    t.integer  "location_id"
    t.integer  "venue_id"
    t.decimal  "advanceprice", :precision => 8, :scale => 2
    t.string   "allowed_in"
  end

  create_table "shows_users", :id => false, :force => true do |t|
    t.integer "show_id"
    t.integer "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.boolean  "admin",           :default => false
    t.integer  "points",          :default => 0
  end

  create_table "venues", :force => true do |t|
    t.string  "name"
    t.string  "address"
    t.integer "location_id"
    t.string  "phone"
    t.string  "website"
  end

end
