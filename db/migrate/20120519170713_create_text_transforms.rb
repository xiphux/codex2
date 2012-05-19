class CreateTextTransforms < ActiveRecord::Migration
  def change
    create_table :text_transforms do |t|
      t.string :pattern
      t.string :replacement
      t.references :chapter

      t.timestamps
    end
    add_index :text_transforms, :chapter_id
  end
end
