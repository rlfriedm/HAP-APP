class AddTextToEdits < ActiveRecord::Migration
  def change
    add_column :edits, :text, :string
  end
end
