class AddStartLatToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :startLat, :float
  end
end
