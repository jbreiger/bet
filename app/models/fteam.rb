class Fteam < ActiveRecord::Base
  belongs_to :team, :class_name => :Teams, :foreign_key=> :team_id
  belongs_to :user
end
