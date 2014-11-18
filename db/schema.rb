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

ActiveRecord::Schema.define(version: 20141117235837) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_details", force: true do |t|
    t.string   "dept"
    t.string   "number"
    t.string   "name"
    t.integer  "credits"
    t.boolean  "writing"
    t.text     "prereq"
    t.text     "coreq"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "year"
    t.string   "term"
  end

  create_table "courses", force: true do |t|
    t.string   "term"
    t.integer  "year"
    t.string   "dept"
    t.string   "number"
    t.string   "section"
    t.integer  "section_number"
    t.string   "name"
    t.string   "city"
    t.string   "style"
    t.boolean  "day_sun"
    t.boolean  "day_mon"
    t.boolean  "day_tue"
    t.boolean  "day_wed"
    t.boolean  "day_thu"
    t.boolean  "day_fri"
    t.boolean  "day_sat"
    t.time     "time_start"
    t.time     "time_end"
    t.string   "room"
    t.string   "location"
    t.boolean  "lab"
    t.string   "lab_style"
    t.string   "lab_location"
    t.boolean  "lab_day_sun"
    t.boolean  "lab_day_mon"
    t.boolean  "lab_day_tue"
    t.boolean  "lab_day_wed"
    t.boolean  "lab_day_thu"
    t.boolean  "lab_day_fri"
    t.boolean  "lab_day_sat"
    t.time     "lab_time_start"
    t.time     "lab_time_end"
    t.string   "prof_name"
    t.integer  "credits"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profs", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
