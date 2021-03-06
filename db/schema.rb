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

ActiveRecord::Schema.define(:version => 20120519170713) do

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

  add_index "authors_fics", ["fic_id", "author_id"], :name => "index_authors_fics_on_fic_id_and_author_id", :unique => true

  create_table "chapters", :force => true do |t|
    t.integer  "fic_id"
    t.integer  "number"
    t.string   "title"
    t.text     "data",                 :limit => 2147483647
    t.string   "file"
    t.boolean  "wrapped"
    t.boolean  "no_paragraph_spacing"
    t.integer  "views",                                      :default => 0, :null => false
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
    t.integer  "word_count"
    t.boolean  "double_line_breaks"
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

  create_table "characters_matchups", :id => false, :force => true do |t|
    t.integer "character_id"
    t.integer "matchup_id"
  end

  add_index "characters_matchups", ["character_id", "matchup_id"], :name => "index_characters_matchups_on_character_id_and_matchup_id", :unique => true

  create_table "fics", :force => true do |t|
    t.string   "title"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "prequel_id"
    t.integer  "main_story_id"
  end

  create_table "fics_genres", :id => false, :force => true do |t|
    t.integer "fic_id"
    t.integer "genre_id"
  end

  add_index "fics_genres", ["fic_id", "genre_id"], :name => "index_fics_genres_on_fic_id_and_genre_id", :unique => true

  create_table "fics_matchups", :id => false, :force => true do |t|
    t.integer "fic_id"
    t.integer "matchup_id"
  end

  add_index "fics_matchups", ["fic_id", "matchup_id"], :name => "index_fics_matchups_on_fic_id_and_matchup_id", :unique => true

  create_table "fics_series", :id => false, :force => true do |t|
    t.integer "fic_id"
    t.integer "series_id"
  end

  add_index "fics_series", ["fic_id", "series_id"], :name => "index_fics_series_on_fic_id_and_series_id", :unique => true

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

  create_table "text_transforms", :force => true do |t|
    t.string   "pattern"
    t.string   "replacement"
    t.integer  "chapter_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "text_transforms", ["chapter_id"], :name => "index_text_transforms_on_chapter_id"

end
