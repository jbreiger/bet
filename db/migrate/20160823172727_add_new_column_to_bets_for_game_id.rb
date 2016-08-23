class AddNewColumnToBetsForGameId < ActiveRecord::Migration
  def change
  	add_column :bets, :game_id, :integer
  end
end
