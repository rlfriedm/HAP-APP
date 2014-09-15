class CreateTrails < ActiveRecord::Migration
  def change
    create_table :trails do |t|
      t.string :name
      t.string :description
      t.integer :rating, :limit => 5

      t.timestamps
    end
  end
end
