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

ActiveRecord::Schema.define(version: 2018_12_05_025832) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.text "im_client_id", null: false
    t.text "file_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries", force: :cascade do |t|
    t.text "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "identities", force: :cascade do |t|
    t.bigint "client_id"
    t.text "identity_number", null: false
    t.text "family_name"
    t.text "first_name"
    t.text "second_name"
    t.text "third_name"
    t.text "gender"
    t.bigint "country_of_birth_id"
    t.text "nationality"
    t.bigint "issuing_state_id"
    t.text "serial_no", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_identities_on_client_id"
    t.index ["country_of_birth_id"], name: "index_identities_on_country_of_birth_id"
    t.index ["issuing_state_id", "serial_no"], name: "index_identities_on_issuing_state_id_and_serial_no", unique: true
    t.index ["issuing_state_id"], name: "index_identities_on_issuing_state_id"
  end

  create_table "movements", force: :cascade do |t|
    t.bigint "identities_id", null: false
    t.text "movement", null: false
    t.datetime "carrier_date_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identities_id"], name: "index_movements_on_identities_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "identities", "countries", column: "country_of_birth_id"
  add_foreign_key "identities", "countries", column: "issuing_state_id"
end
