class AddStartLngToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :startLng, :float
  end
end
