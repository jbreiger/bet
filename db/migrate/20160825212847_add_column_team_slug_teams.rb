class AddColumnTeamSlugTeams < ActiveRecord::Migration
  def change
  	add_column :teams, :team_slug, :string
  end
end
