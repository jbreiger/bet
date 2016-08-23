require 'json'
require 'net/http' #to make a GET request
require 'open-uri'
 $bet_uri = "https://arisalexis-soccer-odds-v1.p.mashape.com/leagues/7?mashape-key=QrOQ23UHkJmshjEicHpK4qPOretkp1rQ2LajsnB3Bi6iCRLl8S"
  $id_uri= "https://arisalexis-soccer-odds-v1.p.mashape.com/matches/39401?mashape-key=QrOQ23UHkJmshjEicHpK4qPOretkp1rQ2LajsnB3Bi6iCRLl8S"
  class BetsController < ApplicationController
   def index
   	 session[:games] =[]

   	 $id_uri= "https://arisalexis-soccer-odds-v1.p.mashape.com/matches/39401?mashape-key=QrOQ23UHkJmshjEicHpK4qPOretkp1rQ2LajsnB3Bi6iCRLl8S"
   	 
   	  uri = URI.parse($bet_uri)		
   	  uri2 =URI.parse($id_uri)		
      #uri = URI.parse($soccer_uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http2 = Net::HTTP.new(uri2.host, uri2.port)

      #to be able to access https URL, these line should be added
      #github api has an https URL
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
      		session[:games] << @id
      	x+=1	
      end	
      puts session[:games]

      # @data2= JSON.load(data2)
      # @data2.each do 
     end
    end 
