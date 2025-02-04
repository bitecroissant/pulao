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

ActiveRecord::Schema[7.1].define(version: 2025_01_25_050523) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_dates", force: :cascade do |t|
    t.string "name"
    t.bigint "group_id"
    t.string "icon_name"
    t.string "icon_color"
    t.string "emoji_icon"
    t.bigint "user_id"
    t.integer "is_deleted"
    t.integer "status"
    t.datetime "happened_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "nick_name"
    t.string "email"
    t.integer "is_deleted"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "validation_codes", force: :cascade do |t|
    t.string "email"
    t.string "code", limit: 128
    t.integer "kind", default: 1, null: false
    t.datetime "used_at"
    t.bigint "user_id"
    t.integer "is_deleted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
