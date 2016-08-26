class Teams < ActiveRecord::Base
	has_many :team_comments
	#belongs_to :user
	has_many :fteams
	has_many :users, :through => :fteams
	# has_many :users, :through => :user_bets
end
