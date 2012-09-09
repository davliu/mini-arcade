class AddUserIdToScores < ActiveRecord::Migration
  def change
    add_column :scores, :user_id, :integer
    add_index :scores, :user_id
  end
end
