class AddTrailIdToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :trail_id, :integer
  end
end
