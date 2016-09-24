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

ActiveRecord::Schema.define(version: 20160922125611) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calender_events", force: true do |t|
    t.string   "event_id"
    t.string   "summary"
    t.string   "location"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "status"
    t.integer  "mailbox_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "email_messages", force: true do |t|
    t.string   "message_id"
    t.string   "from"
    t.string   "to"
    t.string   "cc"
    t.string   "bcc"
    t.string   "subject"
    t.text     "body"
    t.datetime "date"
    t.integer  "mailbox_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mailboxes", force: true do |t|
    t.integer  "user_id",                       null: false
    t.string   "name",                          null: false
    t.string   "email",                         null: false
    t.boolean  "status",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "refresh_token"
    t.string   "expire_at"
    t.text     "access_key"
  end

  create_table "users", force: true do |t|
    t.string   "provider",     null: false
    t.string   "uid",          null: false
    t.string   "name"
    t.string   "location"
    t.string   "image_url"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.text     "access_token"
    t.boolean  "status"
    t.integer  "role"
  end

end
