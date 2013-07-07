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

ActiveRecord::Schema.define(version: 20130707131035) do

  create_table "consulates", force: true do |t|
    t.integer  "country_id"
    t.string   "title"
    t.string   "location"
    t.string   "url"
    t.string   "mail"
    t.string   "telephone"
    t.string   "fulladdress"
    t.string   "contact"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "consulates", ["country_id"], name: "index_consulates_on_country_id"

  create_table "countries", force: true do |t|
    t.string   "openid"
    t.string   "title"
    t.string   "classification"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "wiki"
    t.integer  "price"
    t.string   "weather_main"
    t.string   "weather_temp"
    t.integer  "deaths"
  end

  create_table "dangers", force: true do |t|
    t.integer  "country_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dangers", ["country_id"], name: "index_dangers_on_country_id"

  create_table "prisoners", force: true do |t|
    t.integer  "country_id"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "prisoners", ["country_id"], name: "index_prisoners_on_country_id"

  create_table "reports", force: true do |t|
    t.integer  "country_id"
    t.text     "algemeen"
    t.text     "actueel"
    t.text     "terrorisme"
    t.text     "criminaliteit"
    t.text     "gebieden"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
