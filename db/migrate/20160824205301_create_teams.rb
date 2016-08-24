class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :team

      t.timestamps
    end
  end
end
