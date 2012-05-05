class CreateMatchups < ActiveRecord::Migration
  def change
    create_table :matchups do |t|

      t.timestamps
    end
  end
end
