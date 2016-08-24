class AddColumnToComments < ActiveRecord::Migration
  def change
  	add_reference :team_comments, :user, index: true
  end
end
