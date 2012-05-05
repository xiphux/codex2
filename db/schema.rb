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

ActiveRecord::Schema.define(:version => 20120505220015) do

  create_table "authors", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "website"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "authors_fics", :id => false, :force => true do |t|
    t.integer "author_id"
    t.integer "fic_id"
  end

  create_table "chapters", :force => true do |t|
    t.integer  "fic_id"
    t.integer  "number"
    t.string   "title"
    t.text     "data"
    t.string   "file"
    t.boolean  "wrapped"
    t.boolean  "padlines"
    t.integer  "views"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "chapters", ["fic_id", "number"], :name => "index_chapters_on_fic_id_and_number", :unique => true
  add_index "chapters", ["fic_id"], :name => "index_chapters_on_fic_id"

  create_table "characters", :force => true do |t|
    t.string   "name"
    t.integer  "series_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "characters", ["series_id"], :name => "index_characters_on_series_id"

  create_table "fics", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "fics_genres", :id => false, :force => true do |t|
    t.integer "fic_id"
    t.integer "genre_id"
  end

  create_table "genres", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "matchups", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "series", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
