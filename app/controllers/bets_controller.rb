require 'json'
require 'net/http' #to make a GET request
require 'open-uri'
 $bet_uri = "https://arisalexis-soccer-odds-v1.p.mashape.com/leagues/7?mashape-key=QrOQ23UHkJmshjEicHpK4qPOretkp1rQ2LajsnB3Bi6iCRLl8S"
  $id_uri= "https://arisalexis-soccer-odds-v1.p.mashape.com/matches/39401?mashape-key=QrOQ23UHkJmshjEicHpK4qPOretkp1rQ2LajsnB3Bi6iCRLl8S"
  class BetsController < ApplicationController
   def show
   		@bet= Bet.where(:game_id=> params[:id])
   		@game= @bet.first
   end	
   def create
   	 session[:games] =[]
   	 session[:teams]=[]

   	 
   	  uri = URI.parse($bet_uri)		
   	  uri2 =URI.parse($id_uri)		
      #uri = URI.parse($soccer_uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http2 = Net::HTTP.new(uri2.host, uri2.port)

      http.use_ssl = true
      http2.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http2.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(uri.request_uri)
      request2 = Net::HTTP::Get.new(uri2.request_uri)
      response = http.request(request)
      response2 = http.request(request2)
      #store the body of the requested URI (Uniform Resource Identifier)
      data = response.body
      data2= response2.body
      
      #to parse JSON string; you may also use JSON.parse()
      #JSON.load() turns the data into a hash
      @data = JSON.load(data)

      length= @data.length
      x=0
      while x < length 
      		@id= @data[x]['matchId']
 			@team1= @data[x]['homeTeam']
 				if @team1== "Tottenham Hotspur" 
   					@team1 = "Tottenham"
   				elsif @team1== "BOURNEMOUTH" 
   					@team1 = "Bournemouth"
   				end	
 			@team2= @data[x]['awayTeam']
 				if @team1== "Tottenham Hotspur" 
   					@team1 = "Tottenham"
   				elsif @team1== "BOURNEMOUTH" 
   					@team1 = "Bournemouth"
   				end	
 			puts @team1
 			puts @team2
 			puts @id
      		@bet= Bet.where(:team1 => @team1).where(:team2 => @team2)
      		if @bet.first
      			puts "xxxxxx"
	      		@bet.first.update(game_id: @id)
      		end

      		session[:games] << @id
      		
      	x+=1	
      end	
      puts session[:games]
      redirect_to '/bets'
     end

     def index 
     	 session[:games].each do |i|
	     	 $id_uri= "https://arisalexis-soccer-odds-v1.p.mashape.com/matches/#{i}?mashape-key=QrOQ23UHkJmshjEicHpK4qPOretkp1rQ2LajsnB3Bi6iCRLl8S"

	     	 uri2 =URI.parse($id_uri)
	     	 #http = Net::HTTP.new(uri.host, uri.port)
	     	 http2 = Net::HTTP.new(uri2.host, uri2.port)
	     	 http2.use_ssl = true
	     	 http2.verify_mode = OpenSSL::SSL::VERIFY_NONE
	     	 request2 = Net::HTTP::Get.new(uri2.request_uri)
	     	 response2 = http2.request(request2)
	     	 data2= response2.body
	     	 @data2= JSON.load(data2)
	     	 @home_line = @data2[0]["homeLine"]
	     	 @away_line = @data2[0]["awayLine"]
	     	 @draw_line= @data2[0]["drawLine"]
	     	 
	     	 @bet= Bet.where(game_id: i)
	     	 	if @bet.first
	     	 		@bet.first.update(home_line: @home_line, away_line: @away_line, draw_line: @draw_line)
	     	 	end	
	     session[:games]=[]	 	 	 
	    end 	 
    end  	 
end 
