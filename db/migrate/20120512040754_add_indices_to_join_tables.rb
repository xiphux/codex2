class AddIndicesToJoinTables < ActiveRecord::Migration
  def change
    add_index :authors_fics, [:fic_id, :author_id], :unique => true
    add_index :characters_matchups, [:character_id, :matchup_id], :unique => true
    add_index :fics_genres, [:fic_id, :genre_id], :unique => true
    add_index :fics_matchups, [:fic_id, :matchup_id], :unique => true
    add_index :fics_series, [:fic_id, :series_id], :unique => true
  end
end
