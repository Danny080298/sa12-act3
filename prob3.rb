require 'httparty'
require 'json'

api_key = 'K4CAuPaCtghqjblGlqZmooVEM935iWEX'
city = 'Memphis' 


response = HTTParty.get("https://app.ticketmaster.com/discovery/v2/events.json?apikey=#{api_key}&city=#{city}")


if response.code == 200 
  data = JSON.parse(response.body)

    if data["_embedded"] && data["_embedded"]["events"]
        data["_embedded"]["events"].each do |event|
            name = event["name"]
            venue = event["_embedded"]["venues"][0]["name"] rescue "Unknown venue"
            date = event["dates"]["start"]["localDate"] rescue "Unknown date"
            time = event["dates"]["start"]["localTime"] rescue "Unknown time"
            
            puts "--------------------------"
            puts "Event: #{name}"
            puts "Venue: #{venue}"
            puts "Date: #{date}"
            puts "Time: #{time}"
            puts "--------------------------"
        end
    else
        puts "No events found in #{city}."
    end
end
