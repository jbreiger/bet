class User < ActiveRecord::Base
  	has_many :user_bets
	has_many :bets, :through => :user_bets
	has_many :team_comments
	has_many :match_comments
	has_many :fteams
	has_many :teams, :through=> :fteams, :class_name => :Teams

  	has_secure_password
	validates :name, :birthdate, :username, :email, presence: true
  	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  	validates :email, uniqueness: { :case_sensitive => false }
  	# validates :password, length: { minimum: 8 }
end
