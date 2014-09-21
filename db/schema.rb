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

ActiveRecord::Schema.define(version: 20140921151721) do

  create_table "addresses", force: true do |t|
    t.string   "address1"
    t.string   "address2"
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.string   "zipcode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "children", force: true do |t|
    t.integer  "contact_id"
    t.string   "name"
    t.datetime "birthday"
    t.string   "gender"
    t.string   "relationship"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "role",                        default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "contacts", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",              null: false
    t.string   "company"
    t.string   "address1"
    t.string   "address2"
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.string   "zipcode"
    t.string   "mobile_phone"
    t.string   "alternate_phone"
    t.boolean  "interested_buying"
    t.boolean  "interested_hosting"
    t.boolean  "interested_joining"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.integer  "event_type_id"
    t.string   "name"
    t.boolean  "is_public"
    t.string   "hosting_type"
    t.integer  "host_id"
    t.string   "location_type"
    t.string   "address1"
    t.string   "address2"
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.string   "zipcode"
    t.string   "affiliate_code"
    t.string   "start_date"
    t.string   "start_time"
    t.string   "end_date"
    t.string   "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", force: true do |t|
    t.integer  "noteable_id",   null: false
    t.string   "noteable_type", null: false
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
