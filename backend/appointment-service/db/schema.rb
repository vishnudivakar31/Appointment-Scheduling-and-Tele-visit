# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_05_004005) do

  create_table "appointments", primary_key: "appointment_id", force: :cascade do |t|
    t.integer "patient_id"
    t.date "date"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "practice_id"
    t.integer "doctor_id"
    t.string "appointment_status"
    t.string "chart_file_path"
    t.string "consultation_summary_file_path"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cancelled_by_patients", primary_key: "appointment_id", force: :cascade do |t|
    t.string "cancel_reason"
    t.integer "patient_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cancelled_by_practices", primary_key: "appointment_id", force: :cascade do |t|
    t.string "cancel_reason"
    t.integer "patient_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
