class CreateTeamComments < ActiveRecord::Migration
  def change
    create_table :team_comments do |t|
      t.text :comment
      t.references :teams, index: true

      t.timestamps
    end
  end
end
