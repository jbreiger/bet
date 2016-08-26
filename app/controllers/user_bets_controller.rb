class UserBetsController < ApplicationController
def cashout
	user_bet= UserBet.find(params[:id])
	bet= user_bet.bet
	user= user_bet.user
	wager= user_bet.amount
	pick= user_bet.winner
	
	if user_bet.check == 1
		puts "In the user bet"
		flash[:message] = "You already got your money for this game"	
	else 

		if pick == bet.winner
			if pick == "home"
				winnings= wager.to_f * (bet.home_line).to_f
			elsif pick == "away"
				winnings= wager.to_f * (bet.away_line).to_f
			elsif pick == "draw"
				winnings= wager.to_f * (bet.draw_line).to_f	
			end		
		end	

		if winnings	
			@total= user.money + winnings
			User.find(user).update(money: @total)
			user_bet.update(check: 1)
			flash[:message]= "$#{winnings} has been added to your account!"
		else
			flash[:error] = "Sorry, that isnt a winner"
		
		end	
	end
	redirect_to "/users"
	end

# if outcome== "home" && params[:winner]== "home"
# 		@wager= (params[:amount]).to_f * (@bet.home_line).to_f
# 		puts "home team won and selected home team"
# 		flash[:message]= ["You Won!"]
# 	elsif outcome== "away" && params[:winner]=="away"
# 		@wager= (params[:amount]).to_f * (@bet.away_line).to_f
# 		flash[:message]= ["You Won!"]
# 	elsif outcome== "draw" && params[:winner]== "draw"
# 		@wager= (params[:amount]).to_f * (@bet.draw_line).to_f	
# 		flash[:message] << "You Won!"	
# 	else	
# 		@wager= -(params[:amount].to_f)	
# 		flash[:message] << "You Lost!"
# 	end	
# 	if @wager
# 		@user_money += @wager
# 		@user.update(money: @user_money)

# 	end
# 		redirect_to "/bets/#{@bet.id}"	
	

def create
	flash[:message]= [] 
	@bet= Bet.find(params[:id]) 
	#check(@bet)
	@user= User.find(session[:user_id])
	@user_money= @user.money
	display_bet= params[:amount].to_f
	amount_bet= -(params[:amount].to_f)
	new_total= amount_bet.to_f + @user.money

	 if @user && @bet
		 UserBet.create(user: @user, bet: @bet, amount: params[:amount], winner: params[:winner])
	end

	 if @bet.team1_goal == -1
		puts @bet.team1_goal 
		@user.update(money: new_total)
		flash[:message] = "Your $#{display_bet}0 bet is saved! Your balance is now $#{new_total}0 Check your user page after match has happened to cash out!"
		redirect_to "/bets/#{@bet.id}"
	end	
	# else
	# 	puts @bet.team1_goal
		
	# 	flash[:message] << "Game has happened"

	# if @bet.team1_goal.to_i > @bet.team2_goal.to_i
	# 	outcome= "home"
	# 	puts "home won"
	# elsif @bet.team1_goal.to_i < @bet.team2_goal.to_i
	# 	outcome= "away"
	# 	puts "away won"
	# else
	# 	outcome= "draw"	
	# 	puts "draw"			
	# end
	
	# @bet.update(winner: outcome)

	# if outcome== "home" && params[:winner]== "home"
	# 	@wager= (params[:amount]).to_f * (@bet.home_line).to_f
	# 	puts "home team won and selected home team"
	# 	flash[:message]= ["You Won!"]
	# elsif outcome== "away" && params[:winner]=="away"
	# 	@wager= (params[:amount]).to_f * (@bet.away_line).to_f
	# 	flash[:message]= ["You Won!"]
	# elsif outcome== "draw" && params[:winner]== "draw"
	# 	@wager= (params[:amount]).to_f * (@bet.draw_line).to_f	
	# 	flash[:message] << "You Won!"	
	# else	
	# 	@wager= -(params[:amount].to_f)	
	# 	flash[:message] << "You Lost!"
	# end	
	# if @wager
	# 	@user_money += @wager
	# 	@user.update(money: @user_money)

	# end
	# 	redirect_to "/bets/#{@bet.id}"

	# end
	#@game= @game.first
	
	
end
# def check (@bet)
# 	puts @bet
# 	redirect_to "/bets/#{bet.game_id}"
# end
end
