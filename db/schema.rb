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

ActiveRecord::Schema.define(version: 2019_09_02_054911) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "provider_categories", force: :cascade do |t|
    t.bigint "provider_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_provider_categories_on_category_id"
    t.index ["provider_id"], name: "index_provider_categories_on_provider_id"
  end

  create_table "provider_favourites", force: :cascade do |t|
    t.bigint "provider_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider_id"], name: "index_provider_favourites_on_provider_id"
    t.index ["user_id"], name: "index_provider_favourites_on_user_id"
  end

  create_table "provider_tags", force: :cascade do |t|
    t.bigint "provider_id"
    t.bigint "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider_id"], name: "index_provider_tags_on_provider_id"
    t.index ["tag_id"], name: "index_provider_tags_on_tag_id"
  end

  create_table "providers", force: :cascade do |t|
    t.string "name"
    t.string "translated_name"
    t.text "description"
    t.string "price"
    t.float "avg_rating"
    t.string "street_address"
    t.string "district"
    t.string "city"
    t.string "country"
    t.string "open_hours"
    t.string "phone_number"
    t.string "website"
    t.float "longitude"
    t.float "latitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "review_likes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "review_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["review_id"], name: "index_review_likes_on_review_id"
    t.index ["user_id"], name: "index_review_likes_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "rating"
    t.bigint "provider_id"
    t.bigint "service_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider_id"], name: "index_reviews_on_provider_id"
    t.index ["service_id"], name: "index_reviews_on_service_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "service_favourites", force: :cascade do |t|
    t.bigint "service_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_service_favourites_on_service_id"
    t.index ["user_id"], name: "index_service_favourites_on_user_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.float "avg_rating"
    t.string "street_address"
    t.string "district"
    t.string "city"
    t.string "country"
    t.string "website"
    t.string "open_hours"
    t.string "phone_number"
    t.float "longitude"
    t.float "latitude"
    t.bigint "provider_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider_id"], name: "index_services_on_provider_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_tags_on_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "provider_categories", "categories"
  add_foreign_key "provider_categories", "providers"
  add_foreign_key "provider_favourites", "providers"
  add_foreign_key "provider_favourites", "users"
  add_foreign_key "provider_tags", "providers"
  add_foreign_key "provider_tags", "tags"
  add_foreign_key "review_likes", "reviews"
  add_foreign_key "review_likes", "users"
  add_foreign_key "reviews", "providers"
  add_foreign_key "reviews", "services"
  add_foreign_key "reviews", "users"
  add_foreign_key "service_favourites", "services"
  add_foreign_key "service_favourites", "users"
  add_foreign_key "services", "providers"
  add_foreign_key "tags", "categories"
end
