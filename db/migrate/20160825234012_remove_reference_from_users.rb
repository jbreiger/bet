class RemoveReferenceFromUsers < ActiveRecord::Migration
  def change
  	remove_index :teams, :user_id
  end
end
