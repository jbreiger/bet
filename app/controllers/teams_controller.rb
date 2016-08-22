require 'json'
require 'net/http' #to make a GET request
require 'open-uri' #to fetch the data from the URL to then be parsed by JSON

class TeamsController < ApplicationController
  	  $soccer_uri = "https://sportsop-soccer-sports-open-data-v1.p.mashape.com/v1/leagues/premier-league/seasons/16-17/rounds/giornata-1/matches?mashape-key=QrOQ23UHkJmshjEicHpK4qPOretkp1rQ2LajsnB3Bi6iCRLl8S"
   		#$soccer_uri = "https://sportsop-soccer-sports-open-data-v1.p.mashape.com/v1/leagues?mashape-key=QrOQ23UHkJmshjEicHpK4qPOretkp1rQ2LajsnB3Bi6iCRLl8S
   def index
      uri = URI.parse($soccer_uri)
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
	@data2= @data["data"]["matches"][0]["home"]
	@data2.each do |key, value|
		puts key.to_s + "is " + value.to_s
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

