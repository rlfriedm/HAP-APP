class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :review_id

      t.timestamps
    end
  end
end
