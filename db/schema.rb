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

ActiveRecord::Schema[7.0].define(version: 2022_09_24_220144) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "lastname"
    t.string "nif"
    t.string "street"
    t.string "city"
    t.string "region"
    t.string "postal_code"
    t.string "country"
    t.string "email"
    t.string "telephone"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.string "number"
    t.datetime "date"
    t.datetime "due_date"
    t.decimal "subtotal"
    t.decimal "iva"
    t.decimal "irpf"
    t.decimal "total"
    t.text "notes"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.decimal "price", precision: 8, scale: 2
    t.decimal "tax1"
    t.decimal "tax2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end