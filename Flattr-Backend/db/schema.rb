
ActiveRecord::Schema.define(version: 20150719191125) do
  enable_extension "plpgsql"

  create_table "photos", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "vote_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "photo_url"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "body_type"
    t.string   "gender"
    t.integer  "age"
    t.string   "password"
    t.string   "email"
    t.string   "uid"
    t.string   "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "photo_id"
    t.boolean  "like"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
