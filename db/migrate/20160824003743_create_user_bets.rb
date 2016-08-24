class CreateUserBets < ActiveRecord::Migration
  def change
    create_table :user_bets do |t|
      t.references :user, index: true
      t.references :bet, index: true
      t.float :amount

      t.timestamps
    end
  end
end
