class CreateCharacterMatchupJoinTable < ActiveRecord::Migration
  def change
    create_table :characters_matchups, :id => false do |t|
      t.integer :character_id
      t.integer :matchup_id
    end
  end
end
