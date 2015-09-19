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

ActiveRecord::Schema.define(version: 20150919141039) do

  create_table "connection_statuses", force: :cascade do |t|
    t.boolean  "is_connect"
    t.boolean  "is_disconnect"
    t.text     "info"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name",         null: false
    t.datetime "start",        null: false
    t.datetime "end",          null: false
    t.string   "sensor1_name"
    t.string   "sensor2_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "readings", force: :cascade do |t|
    t.float    "value1"
    t.float    "value2"
    t.datetime "timestamp", null: false
  end

  add_index "readings", ["timestamp"], name: "index_readings_on_timestamp"

end
