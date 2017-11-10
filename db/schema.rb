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

ActiveRecord::Schema.define(version: 20171110140647) do

  create_table "rooms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "room_id"
    t.integer "north"
    t.integer "south"
    t.integer "east"
    t.integer "west"
    t.integer "up"
    t.integer "down"
    t.boolean "hide_north"
    t.boolean "hide_south"
    t.boolean "hide_east"
    t.boolean "hide_west"
    t.boolean "hide_up"
    t.boolean "hide_down"
    t.integer "north_key"
    t.integer "south_key"
    t.integer "east_key"
    t.integer "west_key"
    t.integer "up_key"
    t.integer "down_key"
    t.integer "room_type"
    t.integer "location"
    t.boolean "guards"
    t.boolean "ktp"
    t.integer "default_enemy"
    t.string "description"
    t.string "advanced_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
