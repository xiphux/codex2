class ChangeLengthOnDataChapters < ActiveRecord::Migration
  def up
    change_column :chapters, :data, :text, :limit => 4294967295
  end

  def down
    change_column :chapters, :data, :text, :limit => 65535
  end
end
