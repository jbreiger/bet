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
     @results= Bet.all.order(date: :desc)
     @date= Time.now
   end 
   def show
      standing_uri= "https://sportsop-soccer-sports-open-data-v1.p.mashape.com/v1/leagues/premier-league/seasons/16-17/standings?mashape-key=QrOQ23UHkJmshjEicHpK4qPOretkp1rQ2LajsnB3Bi6iCRLl8S"
       uri = URI.parse(standing_uri)      
      #uri = URI.parse($soccer_uri)
      http = Net::HTTP.new(uri.host, uri.port)
      #to be able to access https URL, these line should be added
      #github api has an https URL
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      data = response.body
      
      #to parse JSON string; you may also use JSON.parse()
      #JSON.load() turns the data into a hash
      @data = JSON.load(data)
      @standings=@data["data"]["standings"]
        count=0
        @standings.each do |x|
          # puts x["team"]
          # puts params[:id]
         if x["team"] == params[:id]
           @team= @data["data"]["standings"][count]
          end
          count+=1   
      end    

    end

   def table
    standing_uri= "https://sportsop-soccer-sports-open-data-v1.p.mashape.com/v1/leagues/premier-league/seasons/16-17/standings?mashape-key=QrOQ23UHkJmshjEicHpK4qPOretkp1rQ2LajsnB3Bi6iCRLl8S"
       uri = URI.parse(standing_uri)      
      #uri = URI.parse($soccer_uri)
      http = Net::HTTP.new(uri.host, uri.port)
      #to be able to access https URL, these line should be added
      #github api has an https URL
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      data = response.body
      
      #to parse JSON string; you may also use JSON.parse()
      #JSON.load() turns the data into a hash
      @data = JSON.load(data)
      @team=@data["data"]["standings"]

   end
   def create
   		for i in 1..3
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
      @team1_goal= @team1_goal.to_i
      #puts @team1_goal.is_an_int? 
		@team2_goal= @data["data"]["matches"][x]["away"]["goals"]
     @team2_goal= @team2_goal.to_i
		@date= @data["data"]["matches"][x]["date_match"]
		@date= @date.to_time
		
		# @seconds= Time.at(1472293801)
		# @seconds= @seconds.to_time
		# puts @seconds

    #Should put something like if home and away team is already included dont create
		Bet.create(team1: @team1, team2: @team2, team1_goal: @team1_goal, team2_goal: @team2_goal, date: @date)
		x+=1
	 end

	end
end
end

