class ChangeGoaltoInteger < ActiveRecord::Migration
  def change
  	remove_column :bets, :team1_goal
  	remove_column :bets, :team2_goal
  	add_column :bets, :team1_goal, :integer
  	add_column :bets, :team2_goal, :integer
  end
end
