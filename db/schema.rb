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

ActiveRecord::Schema.define(version: 20171201223338) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "jobs", force: :cascade do |t|
    t.integer "jobNum"
    t.date "poDate"
    t.string "customer"
    t.text "description"
    t.boolean "needBom"
    t.boolean "bomDone"
    t.string "status"
    t.text "progress"
    t.integer "priority"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "finished", default: false
    t.date "dueDate"
    t.string "work_type"
  end

  create_table "parts", force: :cascade do |t|
    t.string "partNum"
    t.text "description"
    t.integer "totalQuantity"
    t.string "workOrder"
    t.boolean "finish"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "job_id"
    t.integer "quantity"
    t.boolean "finished", default: false
    t.integer "item_num"
    t.index ["job_id"], name: "index_parts_on_job_id"
  end

  create_table "pumps", force: :cascade do |t|
    t.string "product_type"
    t.integer "stages"
    t.integer "flowrate"
    t.integer "dev_head"
    t.string "assembly"
    t.text "restrictions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity"
    t.bigint "job_id"
    t.integer "item_num"
    t.index ["job_id"], name: "index_pumps_on_job_id"
  end

end
