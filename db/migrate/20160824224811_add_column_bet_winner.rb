class AddColumnBetWinner < ActiveRecord::Migration
  def change
  	add_column :bets, :winner, :string
  end
end
