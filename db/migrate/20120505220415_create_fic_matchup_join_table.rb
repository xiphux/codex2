class CreateFicMatchupJoinTable < ActiveRecord::Migration
  def change
    create_table :fics_matchups, :id => false do |t|
      t.integer :fic_id
      t.integer :matchup_id
    end
  end
end
