class AddReviewIdToEdits < ActiveRecord::Migration
  def change
    add_column :edits, :review_id, :integer
  end
end
