class CreateFicSeriesJoinTable < ActiveRecord::Migration
  def change
    create_table :fics_series, :id => false do |t|
      t.integer :fic_id
      t.integer :series_id
    end
  end
end
