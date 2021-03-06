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

ActiveRecord::Schema.define(:version => 20120708095104) do

  create_table "books", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chapters", :force => true do |t|
    t.integer  "book_id"
    t.integer  "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorite_relationships", :force => true do |t|
    t.integer  "user_id"
    t.string   "type"
    t.integer  "favorite_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "headline_relationships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "headline_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "multiple_choice_questions", :force => true do |t|
    t.integer  "verse_id"
    t.text     "content"
    t.text     "a"
    t.text     "b"
    t.text     "c"
    t.text     "d"
    t.string   "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "verse_id"
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "original_inflected_words", :force => true do |t|
    t.integer  "strong_id"
    t.string   "form"
    t.string   "type"
    t.string   "transliteration"
    t.string   "binyan"
    t.string   "tense"
    t.string   "pos"
    t.string   "case"
    t.string   "number"
    t.string   "gender"
    t.string   "person"
    t.string   "mood"
    t.string   "voice"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "original_verses", :force => true do |t|
    t.text     "content"
    t.text     "strong_ids"
    t.string   "type"
    t.integer  "verse_id"
    t.text     "translations"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "original_words", :force => true do |t|
    t.integer  "strong_id"
    t.string   "form"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "transliteration"
    t.string   "phonetic_spelling"
    t.string   "short_definition"
    t.text     "medium_definition"
    t.text     "long_definition"
    t.string   "pos"
    t.string   "normalized_form"
  end

  create_table "related_verses", :force => true do |t|
    t.integer  "relatee_id"
    t.integer  "related_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "search_helpers", :force => true do |t|
    t.integer  "verse_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "chapter_id"
    t.integer  "book_id"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nt_lg"
    t.string   "ot_lg"
    t.string   "name"
    t.string   "image"
    t.integer  "headline_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "verse_history_records", :force => true do |t|
    t.integer  "user_id"
    t.integer  "verse_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "verse_texts", :force => true do |t|
    t.string   "language"
    t.text     "content"
    t.integer  "verse_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "chapter_id"
    t.integer  "book_id"
  end

  create_table "verses", :force => true do |t|
    t.integer  "chapter_id"
    t.integer  "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
