class RenamePadLinesColumn < ActiveRecord::Migration
  def change
    rename_column :chapters, :padlines, :no_paragraph_spacing
  end
end
