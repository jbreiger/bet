class DropUserBets < ActiveRecord::Migration
  def change
  	drop_table :user_bets
  end
end
