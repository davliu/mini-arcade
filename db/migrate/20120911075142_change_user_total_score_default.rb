class ChangeUserTotalScoreDefault < ActiveRecord::Migration
  def self.up
    change_column :users, :total_score, :integer, :default => 0, :null => false
  end
end
