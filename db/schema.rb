# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_27_171730) do

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "administrators", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.string "remember_token"
    t.datetime "remember_token_expires_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bonus_point_completions", force: :cascade do |t|
    t.bigint "participation_id", null: false
    t.bigint "bonus_point_id", null: false
    t.boolean "completed", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bonus_point_id"], name: "index_bonus_point_completions_on_bonus_point_id"
    t.index ["participation_id"], name: "index_bonus_point_completions_on_participation_id"
  end

  create_table "bonus_point_participations", force: :cascade do |t|
    t.bigint "bonus_point_id", null: false
    t.bigint "participation_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bonus_point_id"], name: "index_bonus_point_participations_on_bonus_point_id"
    t.index ["participation_id"], name: "index_bonus_point_participations_on_participation_id"
  end

  create_table "bonus_points", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "lat", precision: 10, scale: 6, null: false
    t.decimal "lng", precision: 10, scale: 6, null: false
    t.string "region"
    t.integer "points"
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_bonus_points_on_event_id"
  end

  create_table "challenge_completions", force: :cascade do |t|
    t.bigint "participation_id"
    t.bigint "challenge_id"
    t.boolean "completed", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["challenge_id"], name: "index_challenge_completions_on_challenge_id"
    t.index ["participation_id"], name: "index_challenge_completions_on_participation_id"
  end

  create_table "challenge_conditions", force: :cascade do |t|
    t.bigint "challenge_id", null: false
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["challenge_id"], name: "index_challenge_conditions_on_challenge_id"
  end

  create_table "challenges", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.boolean "open"
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "points"
    t.index ["event_id"], name: "index_challenges_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer "year"
    t.jsonb "informations"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "start_time"
  end

  create_table "extras", force: :cascade do |t|
    t.bigint "participation_id", null: false
    t.float "points"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["participation_id"], name: "index_extras_on_participation_id"
  end

  create_table "gpx_tracks", force: :cascade do |t|
    t.bigint "participation_id", null: false
    t.float "total_ascent"
    t.float "total_distance"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "multiplier", default: 1.0, null: false
    t.index ["participation_id"], name: "index_gpx_tracks_on_participation_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.datetime "sent_at"
    t.boolean "sent", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notes", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "participations", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "team_id"
    t.boolean "team_ready", default: true
    t.index ["event_id"], name: "index_participations_on_event_id"
    t.index ["user_id"], name: "index_participations_on_user_id"
  end

  create_table "phone_numbers", force: :cascade do |t|
    t.string "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "send_riddles", default: true
    t.boolean "send_messages", default: true
  end

  create_table "riddles", force: :cascade do |t|
    t.string "title", null: false
    t.text "content", null: false
    t.text "answer"
    t.datetime "visible_from"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "event_id"
    t.boolean "sent", default: false
    t.string "sponsor"
    t.index ["event_id"], name: "index_riddles_on_event_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "event_id"
    t.index ["event_id"], name: "index_teams_on_event_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bonus_point_completions", "bonus_points"
  add_foreign_key "bonus_point_completions", "participations"
  add_foreign_key "bonus_point_participations", "bonus_points"
  add_foreign_key "bonus_point_participations", "participations"
  add_foreign_key "bonus_points", "events"
  add_foreign_key "challenge_conditions", "challenges"
  add_foreign_key "challenges", "events"
  add_foreign_key "extras", "participations"
  add_foreign_key "gpx_tracks", "participations"
  add_foreign_key "participations", "events"
  add_foreign_key "participations", "users"
end
