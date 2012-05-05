class CreateAuthorFicJoinTable < ActiveRecord::Migration
  def change
    create_table :authors_fics, :id => false do |t|
      t.integer :author_id
      t.integer :fic_id
    end
  end
end
