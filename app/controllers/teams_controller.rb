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

   def favorite
      user= User.find(session[:user_id])

      @fteam= user.teams.order(created_at: :desc)
   end
   def favorite_create
    user= User.find(session[:user_id])
      team= Teams.find_by_team(params[:id])
      check=Fteam.where(user: user, team: team).first
      puts check
      if check
      flash[:error] = "You already favorited #{team.team}" 
      else
       flash[:message]= "You favorited #{team.team}" 
        Fteam.create(user: user, team: team)
      end 
      redirect_to(:back)
    end
   def index 
     @results= Bet.all.order(date: :desc)
     @date= Time.now
     @practice = Practice.all
     @arsenal = "Arsenal"
   end 
   def betable
    @results= Bet.all.order(date: :desc)
     @date= Time.now
   end 
   def show
      @fteam= params[:id]

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
           @teamid = Teams.find_by(team: @team["team"])
           @comment = TeamComments.where(teams: @teamid)
          end
          count+=1   
      end    

      team_slug= Teams.where(team: params[:id]).first.team_slug
      puts team_slug
      schedule_uri1= "https://soccer.sportsopendata.net/v1/leagues/premier-league/seasons/16-17/rounds?team_identifier=#{team_slug}?mashape-key=QrOQ23UHkJmshjEicHpK4qPOretkp1rQ2LajsnB3Bi6iCRLl8S"
      # puts schedule_uri1
      # uri1 = URI.parse(schedule_uri1)
      # http2 = Net::HTTP.new(uri1.host, uri1.port)
      # #to be able to access https URL, these line should be added
      # #github api has an https URL
      # http2.use_ssl = true
      # http2.verify_mode = OpenSSL::SSL::VERIFY_NONE
      # request2 = Net::HTTP::Get.new(uri1.request_uri)
      # response2 = http.request(request2)
      # data1 = response2.body
      # @data1 = JSON.load(data1)
      # puts "******"
      # puts @data1["data"]['rounds']
     



    end

    # def new_schedule
    #   #team_slug= Teams.where(team: params[:id]).first.team_slug
    #   team_slug= "xy8xez8msmv4qucyabkhhk4rqbimnprx"
    #   puts team_slug
    #   schedule_uri= "https://soccer.sportsopendata.net/v1/leagues/premier-league/seasons/16-17/rounds?team_identifier=xy8xez8msmv4qucyabkhhk4rqbimnprx?mashape-key=QrOQ23UHkJmshjEicHpK4qPOretkp1rQ2LajsnB3Bi6iCRLl8S"
    #   uri = URI.parse(schedule_uri)      
    #   #uri = URI.parse($soccer_uri)
    #   http = Net::HTTP.new(uri.host, uri.port)
    #   #to be able to access https URL, these line should be added
    #   #github api has an https URL
    #   http.use_ssl = true
    #   http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    #   request = Net::HTTP::Get.new(uri.request_uri)
    #   response = http.request(request)
    #   data = response.body
      
    #   #to parse JSON string; you may also use JSON.parse()
    #   #JSON.load() turns the data into a hash
    #   @data = JSON.load(data)
    #   puts @data
    # end  

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
   def schedule
    schedule_uri= "https://sportsop-soccer-sports-open-data-v1.p.mashape.com/v1/leagues/premier-league/seasons/16-17/teams?mashape-key=QrOQ23UHkJmshjEicHpK4qPOretkp1rQ2LajsnB3Bi6iCRLl8S"
      uri = URI.parse(schedule_uri)      
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
      length=@data["data"]["teams"].length
      x=0
      while x<length
      team= @data["data"]["teams"][x]["name"]
      found= Teams.find_by(team:team)
      team_slug=@data["data"]["teams"][x]["identifier"]
      found.update(team_slug:team_slug)
      x+=1
      end
    redirect_to "/teams"  
   end
   def create

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
    d = JSON.load(data)
    team=d["data"]["standings"]
    standings= d["data"]["standings"].length 
    x=0

    while x < standings do
      t= d["data"]["standings"][x]["team"]
      hometeam = Teams.find_by(team: t)
      if hometeam == nil
        puts "zzzzzzzzz"
        puts "Hometeam is equal to nil"
        puts "zzzzzzz"
        Teams.create(team: t)
      else
        hometeam.update(team: t) 
      end
      x+=1
    end
    teamstest = Teams.find_by(team:"Sharks")
    if teamstest == nil
      Teams.create team:"Sharks"
      Teams.create team:"Jets"
      Teams.create team:"Bears"
      Teams.create team:"Clowns"
      Teams.create team:"Average Joes"
      Teams.create team:"Globo Gym"
    end

    #Create dummy data for Practice table
    practicetest = Practice.find_by(team1:"Sharks")
    if practicetest == nil
      Practice.create team1:"Sharks", team2:"Jets", date:"2016-08-14", home_line:"1.5", away_line:"1.9", draw_line:"2.4", team1_goal:"7", team2_goal:"4", winner:"home"
      Practice.create team1:"Bears", team2:"Clowns", date:"2016-08-14", home_line:"1.9", away_line:"1.1", draw_line:"1.9", team1_goal:"1", team2_goal:"2", winner:"away"
      Practice.create team1:"Average Joes", team2:"Globo Gym", date:"2016-08-14", home_line:"50.0", away_line:"0.02", draw_line:"99.0", team1_goal:"5", team2_goal:"4", winner:"home"
    end

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

      bet= Bet.find_by(team1:@team1, team2:@team2)
      #bet_id= Bet.find_by(team1:@team1, team2:@team2).id
      if bet == nil
  		  Bet.create(team1: @team1, team2: @team2, team1_goal: @team1_goal, team2_goal: @team2_goal, date: @date)
      else
        bet.update(team1: @team1, team2: @team2, team1_goal: @team1_goal, team2_goal: @team2_goal, date: @date) 
  		end
      x+=1
	 end

	end
  redirect_to "/bets/create"

end
end

