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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140211140429) do

  create_table "assureds", :force => true do |t|
    t.string   "title"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "contact"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "fee",        :precision => 4, :scale => 2
  end

  create_table "fee_collection_types", :force => true do |t|
    t.string   "type_string"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "maintenance_fund_fees", :force => true do |t|
    t.integer  "maintenance_fund_id"
    t.integer  "year"
    t.string   "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fee_collection_type_id"
    t.string   "how_collected"
    t.string   "other_fee_type"
  end

  create_table "maintenance_funds", :force => true do |t|
    t.string   "name"
    t.string   "collector"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "contact"
    t.text     "instructions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "amenities"
    t.string   "email"
    t.string   "fax"
  end

  create_table "maintenance_orders", :force => true do |t|
    t.integer  "assured_id"
    t.date     "order_date"
    t.date     "report_date"
    t.text     "legal_description"
    t.string   "buyer"
    t.string   "seller"
    t.text     "property_address"
    t.date     "date_checked"
    t.integer  "maintenance_fund_id"
    t.text     "special_instructions"
    t.text     "amenities"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "delinquent"
    t.string   "gf"
    t.string   "hoa_fee"
    t.string   "hoa_fee_year"
    t.string   "hoa_collector"
    t.string   "hoa_street"
    t.string   "hoa_city"
    t.string   "hoa_state"
    t.string   "hoa_zip"
    t.string   "hoa_phone"
    t.string   "order_status"
    t.string   "hoa_email"
    t.string   "hoa_fax"
    t.boolean  "archived",             :default => false
  end

  create_table "order_status_types", :force => true do |t|
    t.string   "type_string"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "text_blocks", :force => true do |t|
    t.string   "name"
    t.text     "text_block"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin",                                 :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
