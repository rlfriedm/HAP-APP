class AddUserIdToTrails < ActiveRecord::Migration
  def change
  	add_column :trails, :user_id, :int
  end
end
