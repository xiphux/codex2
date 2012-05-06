class AddSequelSidestoryLinks < ActiveRecord::Migration
  def change
    add_column :fics, :prequel_id, :integer
    add_column :fics, :main_story_id, :integer
  end
end
