class AddEndLngToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :endLng, :float
  end
end
