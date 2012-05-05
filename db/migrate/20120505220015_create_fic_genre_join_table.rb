class CreateFicGenreJoinTable < ActiveRecord::Migration
  def change
    create_table :fics_genres, :id => false do |t|
      t.integer :fic_id
      t.integer :genre_id
    end
  end
end
