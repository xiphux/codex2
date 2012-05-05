class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.references :series

      t.timestamps
    end
    add_index :characters, :series_id
  end
end
