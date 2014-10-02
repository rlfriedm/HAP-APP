class AddTrailIdToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :trail_id, :integer
  end
end
