class Bet < ActiveRecord::Base
	has_many :user_bets
	has_many :users, :through => :user_bets
end
