class ChangeLinesToBetsToFloat < ActiveRecord::Migration
  def change
  	remove_column :bets, :home_line
  	remove_column :bets, :away_line
  	remove_column :bets, :draw_line
	add_column :bets, :home_line, :float
  	add_column :bets, :away_line, :float
  	add_column :bets, :draw_line, :float
  end
end
