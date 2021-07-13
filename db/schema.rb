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

ActiveRecord::Schema.define(version: 2021_07_13_184530) do

  create_table "payout_lines", force: :cascade do |t|
    t.integer "place"
    t.integer "players_paid"
    t.decimal "percent", precision: 4, scale: 2
  end

  create_table "penalties", force: :cascade do |t|
    t.string "name"
    t.integer "points"
  end

  create_table "penalty_tickets", force: :cascade do |t|
    t.integer "ticket_id"
    t.integer "penalty_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "join_date"
    t.integer "account_balance"
  end

  create_table "prizes", force: :cascade do |t|
    t.integer "tournament_id"
    t.integer "payout_table_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "player_id"
    t.integer "tournament_id"
    t.integer "reentry_number"
    t.boolean "is_active", default: true
  end

  create_table "tournament_types", force: :cascade do |t|
    t.string "name"
    t.integer "buy_in"
    t.integer "max_reentries"
    t.decimal "percent_paid", precision: 4, scale: 2
  end

  create_table "tournaments", force: :cascade do |t|
    t.datetime "date_and_time"
    t.integer "type_id"
    t.integer "extra_prizepool"
    t.boolean "is_reg_open", default: true
    t.boolean "is_active", default: true
  end

end
