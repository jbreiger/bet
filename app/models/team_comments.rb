class TeamComments < ActiveRecord::Base
  belongs_to :teams
  belongs_to :user
end
