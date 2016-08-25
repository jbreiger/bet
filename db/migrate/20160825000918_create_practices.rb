class CreatePractices < ActiveRecord::Migration
  def change
    create_table :practices do |t|
      t.string :team1
      t.string :team2
      t.date :date
      t.float :home_line
      t.float :away_line
      t.float :draw_line
      t.integer :game_id
      t.integer :team1_goal
      t.integer :team2_goal
      t.string :winner

      t.timestamps
    end
  end
end
