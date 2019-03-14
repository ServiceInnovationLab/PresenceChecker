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

ActiveRecord::Schema.define(version: 2019_03_07_042221) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ahoy_events", force: :cascade do |t|
    t.bigint "visit_id"
    t.bigint "user_id"
    t.string "name"
    t.jsonb "properties"
    t.datetime "time"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["properties"], name: "index_ahoy_events_on_properties_jsonb_path_ops", opclass: :jsonb_path_ops, using: :gin
    t.index ["user_id"], name: "index_ahoy_events_on_user_id"
    t.index ["visit_id"], name: "index_ahoy_events_on_visit_id"
  end

  create_table "ahoy_visits", force: :cascade do |t|
    t.string "visit_token"
    t.string "visitor_token"
    t.bigint "user_id"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.string "referring_domain"
    t.text "landing_page"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.string "country"
    t.string "region"
    t.string "city"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.string "app_version"
    t.string "os_version"
    t.string "platform"
    t.datetime "started_at"
    t.index ["user_id"], name: "index_ahoy_visits_on_user_id"
    t.index ["visit_token"], name: "index_ahoy_visits_on_visit_token", unique: true
  end

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
    t.string "country_code"
  end

  create_table "eligibilities", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.date "day", null: false
    t.json "calculation_data", null: false
    t.boolean "minimum_presence", null: false
    t.boolean "each_year_presence", null: false
    t.boolean "five_year_presence", null: false
    t.json "present_days_by_rolling_year", null: false
    t.json "mimimum_presence_by_rolling_year", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id", "day"], name: "index_eligibilities_on_client_id_and_day", unique: true
    t.index ["client_id"], name: "index_eligibilities_on_client_id"
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
    t.text "serial_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_identities_on_client_id"
    t.index ["country_of_birth_id"], name: "index_identities_on_country_of_birth_id"
    t.index ["issuing_state_id", "serial_number"], name: "index_identities_on_issuing_state_id_and_serial_number"
    t.index ["issuing_state_id"], name: "index_identities_on_issuing_state_id"
  end

  create_table "movements", force: :cascade do |t|
    t.bigint "identity_id", null: false
    t.text "direction", null: false
    t.datetime "carrier_date_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "visa_type"
    t.index ["identity_id"], name: "index_movements_on_identity_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "visa_types", force: :cascade do |t|
    t.string "visa_type", null: false
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "visas", force: :cascade do |t|
    t.string "visa_or_permit", null: false
    t.string "single_or_multiple", null: false
    t.date "start_date", null: false
    t.date "expiry_date"
    t.bigint "visa_type_id", null: false
    t.bigint "identity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identity_id"], name: "index_visas_on_identity_id"
    t.index ["visa_type_id"], name: "index_visas_on_visa_type_id"
  end

  add_foreign_key "eligibilities", "clients"
  add_foreign_key "identities", "countries", column: "country_of_birth_id"
  add_foreign_key "identities", "countries", column: "issuing_state_id"
  add_foreign_key "visas", "identities"
  add_foreign_key "visas", "visa_types"
end
