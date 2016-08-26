class AddReferenceUsersToTeams < ActiveRecord::Migration
  def change
  	add_reference :teams, :user, index:true
  end
end
