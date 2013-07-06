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

ActiveRecord::Schema.define(version: 20130706144129) do

  create_table "countries", force: true do |t|
    t.string   "openid"
    t.string   "title"
    t.string   "classification"
    t.integer  "report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prisoners", force: true do |t|
    t.integer  "country_id"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "prisoners", ["country_id"], name: "index_prisoners_on_country_id"

  create_table "reports", force: true do |t|
    t.integer  "country_id"
    t.string   "algemeen"
    t.string   "actueel"
    t.string   "terrorisme"
    t.string   "criminaliteit"
    t.string   "gebieden"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
