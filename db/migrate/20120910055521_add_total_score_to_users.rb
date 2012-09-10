class AddTotalScoreToUsers < ActiveRecord::Migration
  def change
    add_column :users, :total_score, :integer
  end
end
