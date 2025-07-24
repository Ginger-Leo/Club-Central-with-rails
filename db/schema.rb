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

ActiveRecord::Schema[8.0].define(version: 2025_07_14_074222) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "events", force: :cascade do |t|
    t.datetime "datetime", null: false
    t.string "event_type", null: false
    t.string "location"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["datetime"], name: "index_events_on_datetime"
    t.index ["event_type"], name: "index_events_on_event_type"
  end

  create_table "finances", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.text "notes"
    t.string "transaction_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "payer_id"
    t.bigint "payee_id"
    t.index ["created_at"], name: "index_finances_on_created_at"
    t.index ["payee_id"], name: "index_finances_on_payee_id"
    t.index ["payer_id"], name: "index_finances_on_payer_id"
    t.index ["transaction_type"], name: "index_finances_on_transaction_type"
    t.index ["user_id"], name: "index_finances_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username", null: false
    t.string "email", null: false
    t.string "password_digest"
    t.string "access_level", default: "player", null: false
    t.string "position"
    t.string "chain"
    t.boolean "car", default: false, null: false
    t.string "location"
    t.decimal "balance", precision: 10, scale: 2, default: "-100.0", null: false
    t.index ["access_level"], name: "index_users_on_access_level"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "finances", "users"
  add_foreign_key "finances", "users", column: "payee_id"
  add_foreign_key "finances", "users", column: "payer_id"
end
