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

ActiveRecord::Schema.define(version: 2018_08_09_212905) do

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

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "type", limit: 30
    t.integer "width"
    t.integer "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "follows", force: :cascade do |t|
    t.string "followable_type", null: false
    t.bigint "followable_id", null: false
    t.string "follower_type", null: false
    t.bigint "follower_id", null: false
    t.boolean "blocked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followable_id", "followable_type"], name: "fk_followables"
    t.index ["followable_type", "followable_id"], name: "index_follows_on_followable_type_and_followable_id"
    t.index ["follower_id", "follower_type"], name: "fk_follows"
    t.index ["follower_type", "follower_id"], name: "index_follows_on_follower_type_and_follower_id"
  end

  create_table "photocomment_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.integer "generations", null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "photocomment_anc_desc_udx", unique: true
    t.index ["descendant_id"], name: "photocomment_desc_idx"
  end

  create_table "photocomments", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_id"
    t.bigint "schoolpost_id"
    t.bigint "user_id"
    t.index ["schoolpost_id"], name: "index_photocomments_on_schoolpost_id"
    t.index ["user_id"], name: "index_photocomments_on_user_id"
  end

  create_table "posttopics", force: :cascade do |t|
    t.string "topicname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schoolphotos", force: :cascade do |t|
    t.integer "view"
    t.string "photo"
    t.bigint "school_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_schoolphotos_on_school_id"
    t.index ["user_id"], name: "index_schoolphotos_on_user_id"
  end

  create_table "schoolpostcomment_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.integer "generations", null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "schoolpostcomment_anc_desc_udx", unique: true
    t.index ["descendant_id"], name: "schoolpostcomment_desc_idx"
  end

  create_table "schoolpostcomments", force: :cascade do |t|
    t.text "content"
    t.integer "parent_id"
    t.bigint "schoolpost_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schoolpost_id"], name: "index_schoolpostcomments_on_schoolpost_id"
    t.index ["user_id"], name: "index_schoolpostcomments_on_user_id"
  end

  create_table "schoolposts", force: :cascade do |t|
    t.integer "view"
    t.string "title"
    t.text "content"
    t.bigint "school_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "posttopic_id"
    t.index ["posttopic_id"], name: "index_schoolposts_on_posttopic_id"
    t.index ["school_id"], name: "index_schoolposts_on_school_id"
    t.index ["user_id"], name: "index_schoolposts_on_user_id"
  end

  create_table "schoolreviews", force: :cascade do |t|
    t.integer "rating"
    t.text "comment"
    t.bigint "school_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_schoolreviews_on_school_id"
    t.index ["user_id"], name: "index_schoolreviews_on_user_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cnname"
    t.text "schoolintro"
    t.string "schoolimage"
    t.string "communitytype"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "timezone", default: "UTC", null: false
    t.string "language", default: "en", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "superadmin_role", default: false
    t.boolean "supervisor_role", default: false
    t.boolean "user_role", default: true
    t.string "nickname"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "photocomments", "schoolposts"
  add_foreign_key "photocomments", "users"
  add_foreign_key "schoolphotos", "schools"
  add_foreign_key "schoolphotos", "users"
  add_foreign_key "schoolpostcomments", "schoolposts"
  add_foreign_key "schoolpostcomments", "users"
  add_foreign_key "schoolposts", "posttopics"
  add_foreign_key "schoolposts", "schools"
  add_foreign_key "schoolposts", "users"
  add_foreign_key "schoolreviews", "schools"
  add_foreign_key "schoolreviews", "users"
end
