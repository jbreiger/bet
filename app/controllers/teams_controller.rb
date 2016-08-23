require 'json'
require 'net/http' #to make a GET request
require 'open-uri' #to fetch the data from the URL to then be parsed by JSON
	
class TeamsController < ApplicationController
	# def get_teams	
		#for  i in 0..2
  	  $soccer_uri = "https://sportsop-soccer-sports-open-data-v1.p.mashape.com/v1/leagues/premier-league/seasons/16-17/rounds/giornata-1/matches?mashape-key=QrOQ23UHkJmshjEicHpK4qPOretkp1rQ2LajsnB3Bi6iCRLl8S"
   		#$soccer_uri = "https://sportsop-soccer-sports-open-data-v1.p.mashape.com/v1/leagues?mashape-key=QrOQ23UHkJmshjEicHpK4qPOretkp1rQ2LajsnB3Bi6iCRLl8S
   		#end
   	#end	
   def index
   		for i in 1..2
   	  $soccer_week= "https://sportsop-soccer-sports-open-data-v1.p.mashape.com/v1/leagues/premier-league/seasons/16-17/rounds/giornata-#{i}/matches?mashape-key=QrOQ23UHkJmshjEicHpK4qPOretkp1rQ2LajsnB3Bi6iCRLl8S"	
   	  	#This will go through the amount of weeks we want
   	  uri = URI.parse($soccer_week)			
      #uri = URI.parse($soccer_uri)
      http = Net::HTTP.new(uri.host, uri.port)
      #to be able to access https URL, these line should be added
      #github api has an https URL
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
  #     response = http.request(request),
  #     headers:{
  #   "X-Mashape-Key" => "QrOQ23UHkJmshjEicHpK4qPOretkp1rQ2LajsnB3Bi6iCRLl8S",
  #   "Accept" => "application/json"
  # }
      #store the body of the requested URI (Uniform Resource Identifier)
      data = response.body
      
      #to parse JSON string; you may also use JSON.parse()
      #JSON.load() turns the data into a hash
      @data = JSON.load(data)
    @matches= @data["data"]["matches"].length	
    x=0
    while x < @matches do
		@team1= @data["data"]["matches"][x]["home"]["team"]
		@team2= @data["data"]["matches"][x]["away"]["team"]
		@team1_goal= @data["data"]["matches"][x]["home"]["goals"]
		@team2_goal= @data["data"]["matches"][x]["away"]["goals"]
		@date= @data["data"]["matches"][x]["date_match"]
		@date= @date.to_time
		
		# @seconds= Time.at(1472293801)
		# @seconds= @seconds.to_time
		# puts @seconds
		#Bet.create(team1: @team1, team2: @team2, team1_goal: @team1_goal, team2_goal: @team2_goal, date: @date)
		x+=1
	end
	#
	# if session[:array] != nil
	# 	else session[:array]=
	#session[:array] << @data2

	# @data2.each do |key, value|
	# 	puts key.to_s + "is " + value.to_s	
	# end	
	# puts "xxxxxxxxxxxxx"
	# puts i
	end
		#@name= @data["data"]["leagues"][0]["name"]
      # @data2= @data.leagues[0].name
      # puts @data2


      # @data.each do |x|
      # 	puts x
      # 	end
      #@test= @data["leagues"]
  end
end

