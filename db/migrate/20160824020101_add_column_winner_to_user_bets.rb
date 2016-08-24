class AddColumnWinnerToUserBets < ActiveRecord::Migration
  def change
  	add_column :user_bets, :winner, :string
  end
end
