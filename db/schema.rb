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

ActiveRecord::Schema.define(version: 20161020035211) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "ticker"
    t.integer  "cik_number"
    t.bigint   "shares_outstanding"
    t.integer  "confidence_rating"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "forms", force: :cascade do |t|
    t.string   "date"
    t.string   "dcn"
    t.string   "sec_form_url"
    t.integer  "insider_id"
    t.integer  "transactions_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["insider_id"], name: "index_forms_on_insider_id", using: :btree
    t.index ["transactions_id"], name: "index_forms_on_transactions_id", using: :btree
  end

  create_table "images", force: :cascade do |t|
    t.string   "img_path"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_images_on_company_id", using: :btree
  end

  create_table "insiders", force: :cascade do |t|
    t.string   "name"
    t.string   "relationship"
    t.integer  "company_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "insider_score"
    t.index ["company_id"], name: "index_insiders_on_company_id", using: :btree
  end

  create_table "transactions", force: :cascade do |t|
    t.string   "direction"
    t.float    "total_value"
    t.float    "price_per_share"
    t.integer  "shares_transacted"
    t.string   "date"
    t.integer  "insider_id"
    t.integer  "company_id"
    t.integer  "form_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["company_id"], name: "index_transactions_on_company_id", using: :btree
    t.index ["form_id"], name: "index_transactions_on_form_id", using: :btree
    t.index ["insider_id"], name: "index_transactions_on_insider_id", using: :btree
  end

  add_foreign_key "images", "companies"
  add_foreign_key "transactions", "companies"
  add_foreign_key "transactions", "forms"
  add_foreign_key "transactions", "insiders"
end
