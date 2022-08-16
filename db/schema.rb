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

ActiveRecord::Schema[7.0].define(version: 2022_08_14_184506) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "admins", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email"
  end

  create_table "breeds", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "remote_id", null: false
    t.string "name", null: false
    t.text "temperament", null: false
    t.string "origin", null: false
    t.text "description", null: false
    t.integer "child_friendly", null: false
    t.integer "cats_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_breeds_on_name"
    t.index ["remote_id"], name: "index_breeds_on_remote_id"
  end

  create_table "cats", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "remote_id", null: false
    t.string "url", null: false
    t.integer "width", null: false
    t.integer "height", null: false
    t.uuid "breed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["breed_id"], name: "index_cats_on_breed_id"
    t.index ["remote_id"], name: "index_cats_on_remote_id"
  end

  add_foreign_key "cats", "breeds"
end
