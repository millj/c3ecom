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

ActiveRecord::Schema.define(version: 20150415014747) do

  create_table "allocation_order_lines", force: true do |t|
    t.string   "order_num"
    t.string   "item_code"
    t.string   "upc"
    t.integer  "qty_required"
    t.integer  "qty_scanned"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  create_table "allocation_orders", force: true do |t|
    t.string   "order_num"
    t.datetime "order_date"
    t.integer  "order_priority"
    t.boolean  "order_complete"
    t.boolean  "order_processed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "baskets", force: true do |t|
    t.string   "basket_num"
    t.string   "order_num",    default: "Empty"
    t.string   "location_num", default: "0"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "direct_bin_contents", force: true do |t|
    t.string   "bin_name",   limit: 15
    t.string   "item_code",  limit: 15
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "direct_bin_contents", ["item_code"], name: "dbc_ix1", using: :btree

  create_table "fct_axima_controls", force: true do |t|
    t.string   "purchase_order_no"
    t.integer  "status"
    t.string   "vendor_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "shipment_number"
  end

  create_table "fct_countable_stocks", force: true do |t|
    t.string   "location"
    t.string   "bin_code"
    t.integer  "exclude_from_standard"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fct_pack_histories", force: true do |t|
    t.string   "order_num"
    t.string   "user_name"
    t.datetime "processed_at"
    t.datetime "completed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fct_rpro_sos", force: true do |t|
    t.string   "so_sid"
    t.string   "so_no"
    t.string   "invc_sid"
    t.string   "ecommerce_order_no"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "freight_tracking_num"
    t.string   "customer_name"
  end

  create_table "fct_startrack_connote_manuals", force: true do |t|
    t.string   "order_no"
    t.string   "connote"
    t.string   "despatch_date"
    t.string   "name1"
    t.string   "name2"
    t.string   "addr1"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fct_store_pick_scans", force: true do |t|
    t.string   "store_code"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "wpi_code"
    t.string   "wsn_code"
    t.string   "picked_by"
    t.string   "checked_by"
    t.string   "scanned_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "pick_date"
  end

  create_table "fct_vendor_axima_leadtimes", force: true do |t|
    t.string   "vendor_code"
    t.integer  "vendor_turnaround"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_processing_leadtime"
    t.integer  "shipping_leadtime_exp"
    t.integer  "shipping_leadtime_exp_haz"
    t.integer  "shipping_leadtime_reg"
    t.integer  "shipping_leadtime_reg_haz"
    t.integer  "whs_processing_time"
  end

  create_table "items", force: true do |t|
    t.string   "item_code"
    t.string   "description"
    t.string   "vendor_code"
    t.string   "upc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mb_order_statuses", force: true do |t|
    t.string   "order_id"
    t.integer  "order_ecom_status"
    t.integer  "order_rpro_status"
    t.string   "web_order_id"
    t.string   "order_number"
    t.integer  "priority"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.string   "order_id",             limit: 55
    t.string   "order_no",             limit: 15
    t.string   "customer_id",          limit: 45
    t.string   "first_name",           limit: 45
    t.string   "last_name",            limit: 45
    t.string   "email",                limit: 60
    t.datetime "when_created"
    t.integer  "status_id"
    t.datetime "shipping_date"
    t.string   "shipping_ref",         limit: 100
    t.string   "rpro_customer_id",     limit: 45
    t.string   "is_special_request",   limit: 5
    t.text     "special_request_text"
    t.string   "is_gift_wrapped"
    t.string   "billing_address_id",   limit: 45
    t.string   "shipping_address_id",  limit: 45
    t.integer  "shipping_method_id"
    t.string   "phone",                limit: 45
    t.string   "evening_phone",        limit: 45
    t.string   "bl_card_id",           limit: 100
    t.text     "gift_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pick_paths", force: true do |t|
    t.string   "bin_name"
    t.integer  "pick_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin"
    t.boolean  "demand"
    t.boolean  "direct"
    t.boolean  "customer_service"
    t.boolean  "finance"
    t.boolean  "direct2"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
