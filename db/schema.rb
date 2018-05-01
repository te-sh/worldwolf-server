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

ActiveRecord::Schema.define(version: 2018_04_27_172732) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "game_wolves", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "game_id"
    t.uuid "wolf_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_game_wolves_on_game_id"
    t.index ["wolf_id"], name: "index_game_wolves_on_wolf_id"
  end

  create_table "games", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "room_id"
    t.uuid "creator_id"
    t.string "normal_word"
    t.string "wolf_word"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_games_on_creator_id"
    t.index ["room_id"], name: "index_games_on_room_id"
  end

  create_table "rooms", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.integer "order"
    t.string "pass"
    t.datetime "last_access"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "room_id"
    t.boolean "active", default: false
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_users_on_room_id"
    t.index ["token"], name: "index_users_on_token", unique: true
  end

  create_table "votes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "game_id"
    t.uuid "voter_id"
    t.uuid "votee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_votes_on_game_id"
    t.index ["votee_id"], name: "index_votes_on_votee_id"
    t.index ["voter_id"], name: "index_votes_on_voter_id"
  end

end
