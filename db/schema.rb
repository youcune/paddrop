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

ActiveRecord::Schema.define(version: 20140115104901) do

  create_table "sessions", force: true do |t|
    t.integer  "user_id",                             null: false
    t.string   "sid",        limit: 16,               null: false
    t.datetime "expires_at",                          null: false
    t.string   "is_deleted", limit: 1,  default: "0", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["user_id", "sid"], name: "index_sessions_on_user_id_and_sid", unique: true

  create_table "users", force: true do |t|
    t.string   "user_id",                              null: false
    t.string   "access_token",                         null: false
    t.string   "default_path"
    t.string   "is_deleted",   limit: 1, default: "0", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["user_id"], name: "index_users_on_user_id", unique: true

end
