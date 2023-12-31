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

ActiveRecord::Schema[7.0].define(version: 2023_09_04_161818) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "care_guides", force: :cascade do |t|
    t.text "watering"
    t.text "sunlight"
    t.text "pruning"
    t.bigint "plant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plant_id"], name: "index_care_guides_on_plant_id"
  end

  create_table "divisions", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.bigint "user_id", null: false
    t.string "light_direction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_divisions_on_user_id"
  end

  create_table "plant_divisions", force: :cascade do |t|
    t.bigint "plant_id", null: false
    t.bigint "division_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["division_id"], name: "index_plant_divisions_on_division_id"
    t.index ["plant_id"], name: "index_plant_divisions_on_plant_id"
  end

  create_table "plants", force: :cascade do |t|
    t.string "name"
    t.string "scientific_name"
    t.text "description"
    t.string "photo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "light_level"
    t.integer "perenual_id"
    t.bigint "water_frequency_id", null: false
    t.index ["water_frequency_id"], name: "index_plants_on_water_frequency_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "water_frequencies", force: :cascade do |t|
    t.string "frequency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "water_frequency_weekdays", force: :cascade do |t|
    t.bigint "water_frequency_id", null: false
    t.bigint "weekday_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["water_frequency_id"], name: "index_water_frequency_weekdays_on_water_frequency_id"
    t.index ["weekday_id"], name: "index_water_frequency_weekdays_on_weekday_id"
  end

  create_table "waterings", force: :cascade do |t|
    t.date "water_date"
    t.bigint "plant_division_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plant_division_id"], name: "index_waterings_on_plant_division_id"
  end

  create_table "weekdays", force: :cascade do |t|
    t.string "day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "care_guides", "plants"
  add_foreign_key "divisions", "users"
  add_foreign_key "plant_divisions", "divisions"
  add_foreign_key "plant_divisions", "plants"
  add_foreign_key "plants", "water_frequencies"
  add_foreign_key "water_frequency_weekdays", "water_frequencies"
  add_foreign_key "water_frequency_weekdays", "weekdays"
  add_foreign_key "waterings", "plant_divisions"
end
