class DisallowNullViewCount < ActiveRecord::Migration
  def up
  	Chapter.update_all(:views => 0, :views => nil)
  	change_column :chapters, :views, :integer, :default => 0, :null => false
  end

  def down
  	change_column :chapters, :views, :integer, :default => nil, :null => true
  	Chapter.update_all(:views => nil, :views => 0)
  end
end
