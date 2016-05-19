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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140225140024) do

  create_table "binaries", :force => true do |t|
    t.integer  "page_id",           :null => false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "title"
  end

  create_table "comments", :force => true do |t|
    t.integer  "owner_id"
    t.integer  "page_id",    :null => false
    t.string   "body",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["owner_id"], :name => "index_comments_on_owner_id"
  add_index "comments", ["page_id"], :name => "index_comments_on_page_id"

  create_table "favorites", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "page_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "favorites", ["page_id", "user_id"], :name => "index_favorites_on_page_id_and_user_id", :unique => true
  add_index "favorites", ["page_id"], :name => "index_favorites_on_page_id"
  add_index "favorites", ["user_id"], :name => "index_favorites_on_user_id"

  create_table "pages", :force => true do |t|
    t.string   "title",                             :null => false
    t.string   "url_fragment",                      :null => false
    t.boolean  "is_public",       :default => true, :null => false
    t.string   "password_digest"
    t.integer  "owner_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "syntax_id",       :default => 1,    :null => false
  end

  add_index "pages", ["owner_id"], :name => "index_pages_on_owner_id"
  add_index "pages", ["syntax_id"], :name => "index_pages_on_syntax_id"
  add_index "pages", ["url_fragment"], :name => "index_pages_on_url_fragment", :unique => true

  create_table "saved_passwords", :force => true do |t|
    t.integer  "page_id",    :null => false
    t.integer  "user_id",    :null => false
    t.string   "digest",     :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "saved_passwords", ["page_id"], :name => "index_saved_passwords_on_page_id"
  add_index "saved_passwords", ["user_id", "page_id"], :name => "index_saved_passwords_on_user_id_and_page_id", :unique => true
  add_index "saved_passwords", ["user_id"], :name => "index_saved_passwords_on_user_id"

  create_table "session_tokens", :force => true do |t|
    t.integer  "user_id"
    t.string   "token"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "session_tokens", ["user_id"], :name => "index_session_tokens_on_user_id"

  create_table "shares", :force => true do |t|
    t.integer  "page_id",    :null => false
    t.integer  "sharer_id",  :null => false
    t.integer  "sharee_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "shares", ["page_id", "sharee_id"], :name => "index_shares_on_page_id_and_sharee_id", :unique => true
  add_index "shares", ["page_id"], :name => "index_shares_on_page_id"
  add_index "shares", ["sharee_id"], :name => "index_shares_on_sharee_id"
  add_index "shares", ["sharer_id"], :name => "index_shares_on_sharer_id"

  create_table "syntaxes", :force => true do |t|
    t.string   "highlighting", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "title",        :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",        :null => false
    t.string   "email",           :null => false
    t.string   "password_digest", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_reset"
  end

  create_table "versions", :force => true do |t|
    t.integer  "page_id",                   :null => false
    t.text     "body",                      :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "number",     :default => 1, :null => false
  end

end
