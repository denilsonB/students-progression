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

ActiveRecord::Schema[7.0].define(version: 2024_05_22_230137) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "classroom_enrollments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "classroom_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classroom_id"], name: "index_classroom_enrollments_on_classroom_id"
    t.index ["user_id"], name: "index_classroom_enrollments_on_user_id"
  end

  create_table "classrooms", force: :cascade do |t|
    t.string "name"
    t.bigint "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_classrooms_on_author_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "task_id", null: false
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "avaliation"
    t.string "comment"
    t.index ["task_id"], name: "index_feedbacks_on_task_id"
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "task_progresses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "task_id", null: false
    t.integer "progress"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_task_progresses_on_task_id"
    t.index ["user_id"], name: "index_task_progresses_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.bigint "author_id", null: false
    t.bigint "classroom_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "grade_level"
    t.index ["author_id"], name: "index_tasks_on_author_id"
    t.index ["classroom_id"], name: "index_tasks_on_classroom_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "user_type", default: "student"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "grade_level", default: 0
  end

  add_foreign_key "classroom_enrollments", "classrooms"
  add_foreign_key "classroom_enrollments", "users"
  add_foreign_key "classrooms", "users", column: "author_id"
  add_foreign_key "feedbacks", "tasks"
  add_foreign_key "feedbacks", "users"
  add_foreign_key "task_progresses", "tasks"
  add_foreign_key "task_progresses", "users"
  add_foreign_key "tasks", "classrooms"
  add_foreign_key "tasks", "users", column: "author_id"
end
