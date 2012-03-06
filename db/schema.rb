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

ActiveRecord::Schema.define(:version => 20120228070131) do

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

  create_table "original_words", :force => true do |t|
    t.integer  "strong_id"
    t.string   "form"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "related_verses", :force => true do |t|
    t.integer  "relatee_id"
    t.integer  "related_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "verse_texts", :force => true do |t|
    t.string   "language"
    t.text     "content"
    t.integer  "verse_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "verses", :force => true do |t|
    t.integer  "chapter_id"
    t.integer  "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
