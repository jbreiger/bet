class User < ActiveRecord::Base
  	has_secure_password
	validates :name, :birthdate, :username, :email, presence: true
  	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  	validates :email, uniqueness: { :case_sensitive => false }
  	# validates :password, length: { minimum: 8 }
end
