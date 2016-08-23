class AddLinesToBets < ActiveRecord::Migration
  def change
  	add_column :bets, :home_line, :string
  	add_column :bets, :away_line, :string
  	add_column :bets, :draw_line, :string
  end
end
