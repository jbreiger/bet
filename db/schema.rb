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

ActiveRecord::Schema.define(version: 20160825000918) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bets", force: true do |t|
    t.string   "team1"
    t.string   "team2"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date"
    t.float    "home_line"
    t.float    "away_line"
    t.float    "draw_line"
    t.integer  "game_id"
    t.integer  "team1_goal"
    t.integer  "team2_goal"
    t.string   "winner"
  end

  create_table "practices", force: true do |t|
    t.string   "team1"
    t.string   "team2"
    t.date     "date"
    t.float    "home_line"
    t.float    "away_line"
    t.float    "draw_line"
    t.integer  "game_id"
    t.integer  "team1_goal"
    t.integer  "team2_goal"
    t.string   "winner"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_comments", force: true do |t|
    t.text     "comment"
    t.integer  "teams_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "team_comments", ["teams_id"], name: "index_team_comments_on_teams_id", using: :btree
  add_index "team_comments", ["user_id"], name: "index_team_comments_on_user_id", using: :btree

  create_table "teams", force: true do |t|
    t.string   "team"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_bets", force: true do |t|
    t.integer  "user_id"
    t.integer  "bet_id"
    t.float    "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "winner"
    t.integer  "check"
  end

  add_index "user_bets", ["bet_id"], name: "index_user_bets_on_bet_id", using: :btree
  add_index "user_bets", ["user_id"], name: "index_user_bets_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "name"
    t.date     "birthdate"
    t.float    "money"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
