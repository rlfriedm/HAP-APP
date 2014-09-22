class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :bodyText
      t.integer :rating
      t.trail_id
      t.timestamps
    end
  end
end
