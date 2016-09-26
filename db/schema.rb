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

ActiveRecord::Schema.define(version: 20160913220550) do

  create_table "passwords", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "vendor_id"
    t.string   "username"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_passwords_on_user_id"
    t.index ["vendor_id"], name: "index_passwords_on_vendor_id"
  end

  create_table "uploads", force: :cascade do |t|
    t.integer  "vendor_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "status_code",       default: 0,  null: false
    t.string   "comment",           default: "", null: false
    t.index ["vendor_id"], name: "index_uploads_on_vendor_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "access_level", default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "objectguid"
    t.index ["access_level"], name: "index_users_on_access_level"
  end

  create_table "vendors", force: :cascade do |t|
    t.string   "title"
    t.string   "link"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

end
