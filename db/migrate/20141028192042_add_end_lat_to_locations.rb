class AddEndLatToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :endLat, :float
  end
end
