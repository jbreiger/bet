class MatchComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :bets
end
