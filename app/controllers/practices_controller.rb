class PracticesController < ApplicationController
	def index
		@match = Practice.find(params[:id])
	end

	def bet
		match = Practice.find(params[:id])
		if match.team1_goal > match.team2_goal && params[:winner] == "home"
			@wager= (params[:amount]).to_f * (match.home_line).to_f
			puts "home team won and selected home team"
			flash[:message]= "You Won $#{@wager}!"		elsif match.team1_goal < match.team2_goal && params[:winner] == "away"
			@wager= (params[:amount]).to_f * (match.away_line).to_f
			flash[:message]= "You Won $#{@wager}!"
	elsif match.team1_goal == match.team2_goal && params[:winner] == "draw"
			@wager= (params[:amount]).to_f * (match.draw_line).to_f	
			flash[:message] = "You Won $#{@wager}!"
		else	
			@wager= (params[:amount].to_f)	
			flash[:message] = "You Lost $#{@wager}!"
		end	
		redirect_to "/practice/#{match.id}"
	end
end
