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

ActiveRecord::Schema.define(version: 20130814162639) do

  create_table "companies", force: true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "description"
    t.string   "mission"
    t.integer  "creator"
  end

  add_index "companies", ["creator"], name: "index_companies_on_creator"
  add_index "companies", ["user_id", "created_at"], name: "index_companies_on_user_id_and_created_at"

  create_table "connections", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "connections", ["followed_id"], name: "index_connections_on_followed_id"
  add_index "connections", ["follower_id", "followed_id"], name: "index_connections_on_follower_id_and_followed_id", unique: true
  add_index "connections", ["follower_id"], name: "index_connections_on_follower_id"

  create_table "memberships", force: true do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.boolean  "exec"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "creator"
  end

  add_index "memberships", ["company_id"], name: "index_memberships_on_company_id"
  add_index "memberships", ["creator"], name: "index_memberships_on_creator"
  add_index "memberships", ["user_id", "company_id"], name: "index_memberships_on_user_id_and_company_id", unique: true
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.boolean  "admin",              default: false
    t.string   "major"
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
