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

ActiveRecord::Schema[8.1].define(version: 2026_05_27_193100) do
  create_table "refresh_tokens", id: :string, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "expires_at", null: false
    t.string "ip_address"
    t.datetime "last_used_at"
    t.datetime "revoked_at"
    t.string "token_digest", null: false
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.string "user_id", null: false
    t.index ["token_digest"], name: "index_refresh_tokens_on_token_digest", unique: true
    t.index ["user_id"], name: "index_refresh_tokens_on_user_id"
  end

  create_table "users", id: :string, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.datetime "email_verified_at"
    t.integer "failed_login_attempts", default: 0, null: false
    t.string "first_name"
    t.datetime "last_login_at"
    t.string "last_name"
    t.datetime "locked_until"
    t.datetime "password_changed_at"
    t.string "password_digest", null: false
    t.string "role", default: "user", null: false
    t.string "status", default: "active", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "refresh_tokens", "users"
end
