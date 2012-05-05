class CreateFics < ActiveRecord::Migration
  def change
    create_table :fics do |t|
      t.string :title

      t.timestamps
    end
  end
end
