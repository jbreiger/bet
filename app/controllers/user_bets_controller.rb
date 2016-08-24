class UserBetsController < ApplicationController
def create
	flash[:message]= [] 
	@bet= Bet.find(params[:id])
	#check(@bet)
	@user= User.find(session[:user_id])
	@user_money= @user.money
	
	 if @user && @bet
		 UserBet.create(user: @user, bet: @bet, amount: params[:amount], winner: params[:winner])
	end
	
	#@userbet= Userbet.find(user: @user, bet: @bet)
	#@userbet.bet

	# puts @bet.team1_goal, "team1goal"
	# puts @bet.team2_goal, "team2goal"
	# puts @bet.home_line, "homeline"
	# puts params[:amount], "amount bet"
	if @bet.team1_goal == -1
		puts @bet.team1_goal 
		flash[:message] = ["Game hasnt happened yet your bet is saved"]
	else
		puts @bet.team1_goal
		
		flash[:message] << "Game has happened"

	if @bet.team1_goal.to_i > @bet.team2_goal.to_i
		outcome= "home"
		puts "home won"
	elsif @bet.team1_goal.to_i < @bet.team2_goal.to_i
		outcome= "away"
		puts "away won"
	else
		outcome= "draw"	
		puts "draw"			
	end
	if outcome== "home" && params[:winner]== "home"
		@wager= (params[:amount]).to_f * (@bet.home_line).to_f
		puts "home team won and selected home team"
		flash[:message]= ["You Won!"]
	elsif outcome== "away" && params[:winner]=="away"
		@wager= (params[:amount]).to_f * (@bet.away_line).to_f
		flash[:message]= ["You Won!"]
	elsif outcome== "draw" && params[:winner]== "draw"
		@wager= (params[:amount]).to_f * (@bet.draw_line).to_f	
		flash[:message] << "You Won!"	
	else	
		@wager= -(params[:amount].to_f)	
		flash[:message] << "You Lost!"
	end	
	if @wager
		@user_money += @wager
		@user.update(money: @user_money)

	end
	end
	#@game= @game.first
	
	
	redirect_to "/bets/#{@bet.game_id}"
end
# def check (@bet)
# 	puts @bet
# 	redirect_to "/bets/#{bet.game_id}"
# end
end
