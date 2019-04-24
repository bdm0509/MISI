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

ActiveRecord::Schema.define(version: 20190422232146) do

  create_table "assureds", force: :cascade do |t|
    t.string "title"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "phone"
    t.string "contact"
    t.float "fee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "collection_districts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "district_types", force: :cascade do |t|
    t.string "type_string"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
  end

  create_table "fee_collection_types", force: :cascade do |t|
    t.string "type_string"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "maintenance_fund_fees", force: :cascade do |t|
    t.integer "maintenance_fund_id"
    t.string "year"
    t.string "amount"
    t.string "how_collected"
    t.string "other_fee_type"
    t.integer "fee_collection_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "maintenance_funds", force: :cascade do |t|
    t.string "name"
    t.string "collector"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "phone"
    t.string "contact"
    t.text "instructions"
    t.text "amenities"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "fax"
  end

  create_table "maintenance_orders", force: :cascade do |t|
    t.integer "assured_id"
    t.date "order_date"
    t.date "report_date"
    t.text "legal_description"
    t.string "buyer"
    t.string "seller"
    t.text "property_address"
    t.date "date_checked"
    t.integer "maintenance_fund_id"
    t.text "special_instructions"
    t.text "amenities"
    t.text "delinquent"
    t.string "gf"
    t.string "hoa_fee"
    t.string "hoa_fee_year"
    t.string "hoa_collector"
    t.string "hoa_street"
    t.string "hoa_city"
    t.string "hoa_state"
    t.string "hoa_zip"
    t.string "hoa_phone"
    t.string "order_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "archived", default: false
    t.string "hoa_fax"
    t.string "hoa_email"
  end

  create_table "order_status_types", force: :cascade do |t|
    t.string "type_string"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tax_certificates", force: :cascade do |t|
    t.string "gf"
    t.string "certificate"
    t.integer "order"
    t.string "buyer"
    t.text "property_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "archived"
    t.string "assessed_owner"
    t.text "tax_description"
    t.text "additional_information"
    t.string "date"
    t.string "fee"
    t.string "cad_value"
    t.integer "assured_id"
  end

  create_table "tax_entries", force: :cascade do |t|
    t.integer "collection_district_id"
    t.integer "district_type_id"
    t.string "account_number"
    t.string "year"
    t.string "base_tax"
    t.integer "tax_status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tax_certificate_id"
  end

  create_table "tax_statuses", force: :cascade do |t|
    t.string "status"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "text_blocks", force: :cascade do |t|
    t.string "name"
    t.text "text_block"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
