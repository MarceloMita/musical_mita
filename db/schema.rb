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

ActiveRecord::Schema.define(version: 20170326131154) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "user_type"
    t.integer  "user_id"
    t.string   "street"
    t.string   "street_number"
    t.string   "complement"
    t.string   "district"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zip_code"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["user_type", "user_id"], name: "index_addresses_on_user_type_and_user_id", using: :btree
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer  "cart_id"
    t.integer  "product_id"
    t.integer  "quantity",   default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["cart_id"], name: "index_cart_items_on_cart_id", using: :btree
    t.index ["product_id"], name: "index_cart_items_on_product_id", using: :btree
  end

  create_table "carts", force: :cascade do |t|
    t.integer  "client_id"
    t.string   "session_id"
    t.integer  "status",          default: 0
    t.string   "moip_order_id"
    t.string   "moip_payment_id"
    t.string   "cupon"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["client_id"], name: "index_carts_on_client_id", using: :btree
    t.index ["session_id", "status"], name: "index_carts_on_session_id_and_status", using: :btree
    t.index ["session_id"], name: "index_carts_on_session_id", using: :btree
  end

  create_table "clients", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "name"
    t.date     "birthdate"
    t.string   "cpf"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_clients_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true, using: :btree
  end

  create_table "cupons", force: :cascade do |t|
    t.string   "code"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "phones", force: :cascade do |t|
    t.string   "user_type"
    t.integer  "user_id"
    t.string   "country_code"
    t.string   "area_code"
    t.string   "number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["user_type", "user_id"], name: "index_phones_on_user_type_and_user_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string   "title"
    t.string   "cached_slug"
    t.text     "description"
    t.string   "image_name"
    t.float    "value"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["cached_slug"], name: "index_products_on_cached_slug", using: :btree
  end

  create_table "slugs", force: :cascade do |t|
    t.string   "scope"
    t.string   "slug"
    t.integer  "record_id"
    t.datetime "created_at"
    t.index ["scope", "record_id", "created_at"], name: "index_slugs_on_scope_and_record_id_and_created_at", using: :btree
    t.index ["scope", "record_id"], name: "index_slugs_on_scope_and_record_id", using: :btree
    t.index ["scope", "slug", "created_at"], name: "index_slugs_on_scope_and_slug_and_created_at", using: :btree
    t.index ["scope", "slug"], name: "index_slugs_on_scope_and_slug", using: :btree
  end

end
