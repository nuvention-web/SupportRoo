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

ActiveRecord::Schema.define(version: 20150517201338) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boards", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
    t.string   "description"
  end

  create_table "invites", force: :cascade do |t|
    t.integer  "board_id"
    t.string   "code"
    t.boolean  "claimed",    default: false
    t.string   "email"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "invites", ["code"], name: "index_invites_on_code", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "task_id"
    t.boolean  "sent_by_us"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "signups", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "first_name"
    t.string   "last_name"
  end

  create_table "supporters", force: :cascade do |t|
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "board_id"
    t.integer  "user_id"
    t.boolean  "owner",      default: false
  end

  create_table "task_types", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "category"
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "task_type_id"
    t.integer  "board_id"
    t.boolean  "shared"
    t.boolean  "accepted"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "supporter_email"
    t.string   "supporter_message"
    t.string   "supporter_name"
    t.string   "title"
    t.integer  "user_id"
    t.boolean  "completed?",            default: false
    t.boolean  "pinned?",               default: false
    t.boolean  "completion_check",      default: false
    t.datetime "completion_check_time"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
