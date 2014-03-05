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

ActiveRecord::Schema.define(version: 20130918010404) do

  create_table "addresses", force: true do |t|
    t.string   "location_name"
    t.string   "line1"
    t.string   "line2"
    t.string   "city"
    t.string   "province"
    t.string   "postal_code"
    t.string   "country"
    t.string   "locale"
    t.integer  "lock_version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "catalogue_sharings", force: true do |t|
    t.integer "catalogue_id"
    t.integer "assignee_id"
    t.string  "assignee_type", null: false
  end

  create_table "catalogued_products", force: true do |t|
    t.integer  "product_id",                                                    null: false
    t.integer  "catalogue_id",                                                  null: false
    t.decimal  "sell_unit_tax",            precision: 19, scale: 4
    t.decimal  "sell_unit_price",          precision: 19, scale: 4
    t.decimal  "sell_unit_tax_percentage", precision: 19, scale: 4
    t.integer  "lock_version",                                      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "catalogues", force: true do |t|
    t.string   "type"
    t.string   "name",                     null: false
    t.integer  "owner_id"
    t.string   "owner_type",               null: false
    t.boolean  "is_default"
    t.boolean  "is_public"
    t.boolean  "is_deleted"
    t.integer  "lock_version", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.integer  "organisation_id"
    t.integer  "person_id"
    t.integer  "lock_version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "directory_profiles", force: true do |t|
    t.integer  "organisation_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.boolean  "published"
    t.string   "website_url"
    t.integer  "lock_version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "identities", force: true do |t|
    t.string   "type"
    t.string   "title"
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "fax"
    t.integer  "address_id"
    t.string   "business_number"
    t.integer  "owner_id"
    t.string   "time_zone",       default: "UTC"
    t.string   "locale"
    t.integer  "lock_version"
    t.boolean  "is_deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "classic_mbid"
  end

  create_table "invoices", force: true do |t|
    t.string   "invoice_number"
    t.integer  "purchase_order_id"
    t.integer  "creator_id"
    t.integer  "owner_id"
    t.datetime "date"
    t.decimal  "total_value",                 precision: 19, scale: 4
    t.decimal  "total_tax_value",             precision: 19, scale: 4
    t.decimal  "delivery_charge_ex_tax",      precision: 19, scale: 4, default: 0.0
    t.decimal  "delivery_charge_tax",         precision: 19, scale: 4, default: 0.0
    t.integer  "payment_term_number_of_days"
    t.decimal  "payment_term_discount_rate",  precision: 19, scale: 4, default: 0.0
    t.string   "payment_term_comment"
    t.datetime "payment_date"
    t.decimal  "adjustment_ex_tax",           precision: 19, scale: 4, default: 0.0
    t.decimal  "adjustment_tax",              precision: 19, scale: 4, default: 0.0
    t.integer  "lock_version",                                         default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_items", force: true do |t|
    t.string   "type"
    t.text     "product"
    t.decimal  "unit_price",             precision: 19, scale: 4
    t.decimal  "tax_amount",             precision: 19, scale: 4
    t.decimal  "quantity",               precision: 19, scale: 4
    t.decimal  "line_tax",               precision: 19, scale: 4
    t.decimal  "line_total",             precision: 19, scale: 4
    t.integer  "product_id"
    t.integer  "supply_document_id"
    t.integer  "catalogue_id"
    t.integer  "supplier_id"
    t.integer  "delivery_address_id"
    t.integer  "preceding_item_id"
    t.string   "supply_document_type"
    t.decimal  "tax_percentage",         precision: 19, scale: 4, default: 0.0
    t.decimal  "price_premium",          precision: 19, scale: 4, default: 0.0
    t.datetime "expected_delivery_date"
    t.string   "locale",                                          default: "en", null: false
    t.integer  "lock_version",                                    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organisation_group_memberships", id: false, force: true do |t|
    t.integer "organisation_id"
    t.integer "organisation_group_id"
  end

  create_table "organisation_groups", force: true do |t|
    t.string   "type"
    t.string   "name",            null: false
    t.integer  "owner_id"
    t.boolean  "default"
    t.boolean  "customers_group"
    t.string   "classic_mbid"
    t.string   "country"
    t.integer  "lock_version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organisation_profiles", force: true do |t|
    t.integer  "organisation_id"
    t.string   "description"
    t.string   "website_url"
    t.string   "pjia_profile_url"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.integer  "lock_version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.text     "item_description"
    t.decimal  "item_size",                          precision: 19, scale: 4
    t.string   "item_measure"
    t.string   "item_pack_name"
    t.decimal  "item_sell_quantity",                 precision: 19, scale: 4
    t.string   "item_sell_pack_name"
    t.string   "brand"
    t.string   "range_model"
    t.string   "manufacturer_code"
    t.string   "manufacturer"
    t.string   "item_description_qualifier"
    t.string   "average_weight_quantity"
    t.string   "average_weight_measure"
    t.string   "package_quantity_weight"
    t.string   "package_quantity_weight_measure"
    t.string   "package_quantity_length_dimension"
    t.string   "package_quantity_width_dimension"
    t.string   "package_quantity_height_dimension"
    t.string   "package_quantity_dimension_measure"
    t.string   "package_inner"
    t.string   "country_of_origin"
    t.string   "region"
    t.string   "package_quantity"
    t.string   "item_sell_measure"
    t.string   "state_province"
    t.text     "concatenated_brand"
    t.text     "concatenated_description"
    t.string   "concatenated_sell_unit"
    t.string   "locale",                                                                  null: false
    t.integer  "lock_version",                                                default: 0
    t.string   "classic_mbid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchase_orders", force: true do |t|
    t.string   "type"
    t.string   "purchase_order_number"
    t.datetime "expected_delivery_date"
    t.decimal  "total_value",            precision: 19, scale: 4
    t.decimal  "total_tax_value",        precision: 19, scale: 4
    t.integer  "requisition_id"
    t.integer  "supplier_id"
    t.integer  "purchaser_id"
    t.integer  "creator_id"
    t.integer  "delivery_address_id"
    t.integer  "consolidated_order_id"
    t.datetime "sent_date"
    t.decimal  "created_at_offset"
    t.decimal  "sent_date_offset"
    t.integer  "lock_version",                                    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchasers", force: true do |t|
    t.integer  "organisation_id"
    t.integer  "billing_address_id"
    t.integer  "delivery_address_id"
    t.boolean  "can_order_from_master_catalogue"
    t.boolean  "allow_override_purchase_requisition_number"
    t.boolean  "allow_override_purchase_order_number"
    t.boolean  "allow_override_invoice_number"
    t.boolean  "check_price_on_approval"
    t.boolean  "deleted"
    t.integer  "lock_version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "receiving_documents", force: true do |t|
    t.string   "receiving_document_number"
    t.integer  "purchase_order_id"
    t.integer  "creator_id"
    t.integer  "owner_id"
    t.datetime "date",                                  null: false
    t.integer  "lock_version",              default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requisitions", force: true do |t|
    t.string   "requisition_number",                                                     null: false
    t.datetime "expected_delivery_date", limit: 23
    t.decimal  "total_value",                       precision: 19, scale: 4
    t.decimal  "total_tax_value",                   precision: 19, scale: 4
    t.integer  "purchaser_id"
    t.integer  "creator_id"
    t.integer  "catalogue_id"
    t.integer  "delivery_address_id"
    t.integer  "lock_version",                                               default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suppliers", force: true do |t|
    t.integer  "organisation_id"
    t.boolean  "verified"
    t.string   "orders_locale"
    t.boolean  "allow_override_invoice_number"
    t.boolean  "is_deleted"
    t.integer  "lock_version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trade_relationships", force: true do |t|
    t.integer  "purchaser_id"
    t.integer  "supplier_id"
    t.boolean  "is_enabled"
    t.string   "supplier_number"
    t.string   "customer_number"
    t.integer  "lock_version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
