class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.references :fic
      t.integer :number
      t.string :title
      t.text :data
      t.string :file
      t.boolean :wrapped
      t.boolean :padlines
      t.integer :views

      t.timestamps
    end
    add_index :chapters, :fic_id
    add_index :chapters, [:fic_id, :number], :unique => true
  end
end
