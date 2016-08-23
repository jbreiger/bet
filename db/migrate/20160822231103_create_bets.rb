class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.string :team1
      t.string :team2
      t.string :team1_goal
      t.string :team2_goal

      t.timestamps
    end
  end
end
