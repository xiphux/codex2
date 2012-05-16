class AddDoubleLineBreaksColumn < ActiveRecord::Migration
  def change
    add_column :chapters, :double_line_breaks, :boolean
  end
end
