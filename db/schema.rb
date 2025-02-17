# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_02_17_005822) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "daily_progs", force: :cascade do |t|
    t.bigint "goal_id", null: false
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "completed"
    t.datetime "completed_at"
    t.index ["goal_id", "date"], name: "index_daily_progs_on_goal_id_and_date", unique: true
    t.index ["goal_id"], name: "index_daily_progs_on_goal_id"
  end

  create_table "goals", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "task_progs", force: :cascade do |t|
    t.bigint "daily_prog_id", null: false
    t.bigint "task_id", null: false
    t.boolean "completed"
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
    t.index ["daily_prog_id", "task_id"], name: "index_task_progs_on_daily_prog_id_and_task_id", unique: true
    t.index ["daily_prog_id"], name: "index_task_progs_on_daily_prog_id"
    t.index ["task_id"], name: "index_task_progs_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "order"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "goal_id", null: false
    t.index ["goal_id"], name: "index_tasks_on_goal_id"
  end

  create_table "users", force: :cascade do |t|
    t.date "timezone"
    t.string "username"
    t.string "email"
    t.boolean "show_progress", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "daily_progs", "goals"
  add_foreign_key "task_progs", "daily_progs"
  add_foreign_key "task_progs", "tasks"
  add_foreign_key "tasks", "goals"
end
