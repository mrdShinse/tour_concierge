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

ActiveRecord::Schema.define(version: 20180101160747) do

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "player_id", null: false, comment: "アーティストID"
    t.integer "venue_id", comment: "会場ID"
    t.string "name", comment: "イベント名"
    t.datetime "start_at", comment: "開始時間"
    t.string "import", null: false, comment: "インポート元"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["import"], name: "index_events_on_import"
  end

  create_table "players", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false, comment: "アーティスト名"
    t.string "import", null: false, comment: "インポート元"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["import"], name: "index_players_on_import"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "venues", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false, comment: "会場名"
    t.string "zipcode", limit: 7, comment: "郵便番号"
    t.text "address", comment: "住所"
    t.text "access", comment: "アクセス"
    t.float "latitude", limit: 53, comment: "緯度"
    t.float "longitude", limit: 53, comment: "経度"
    t.string "capacity", comment: "キャパシティ"
    t.text "url", comment: "公式URL"
    t.string "import", null: false, comment: "インポート元"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["import"], name: "index_venues_on_import"
    t.index ["latitude", "longitude"], name: "index_venues_on_latitude_and_longitude"
  end

end
