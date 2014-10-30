class AddPathToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :path, :text
  end
end
