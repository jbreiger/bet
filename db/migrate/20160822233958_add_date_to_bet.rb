class AddDateToBet < ActiveRecord::Migration
  def change
  	add_column :bets, :date, :date
  end
end
