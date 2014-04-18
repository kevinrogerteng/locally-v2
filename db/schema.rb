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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140409173143) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.text     "description"
    t.string   "display_phone"
    t.string   "biz_url"
    t.string   "thumbnail_photo"
    t.string   "rating"
    t.integer  "trip_id"
    t.string   "yid"
    t.boolean  "completed",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["trip_id"], name: "index_activities_on_trip_id", using: :btree

  create_table "trips", force: true do |t|
    t.string   "name"
    t.string   "destination"
    t.text     "description"
    t.boolean  "completed",   default: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trips", ["user_id"], name: "index_trips_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "screen_name"
    t.string   "hometown"
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
