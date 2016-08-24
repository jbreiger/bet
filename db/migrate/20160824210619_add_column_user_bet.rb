class AddColumnUserBet < ActiveRecord::Migration
  def change
  	add_column :user_bets, :check, :integer
  end
end
