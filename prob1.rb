require 'httparty'
require 'json'

api_key = 'e4302932fec649639d4193849242603' 
city = 'Memphis'


weather_response = HTTParty.get("http://api.weatherapi.com/v1/current.json?key=#{api_key}&q=#{city}&aqi=no")

forecast_response = HTTParty.get("http://api.weatherapi.com/v1/forecast.json?key=#{api_key}&q=#{city}&days=1&aqi=no&alerts=no")

if weather_response.code == 200 && forecast_response.code == 200
    weather_data = JSON.parse(weather_response.body)
    forecast_data = JSON.parse(forecast_response.body)
    

    temperature = weather_data['current']['temp_c']
    humidity = weather_data['current']['humidity']
    weather_conditions = weather_data['current']['condition']['text']
    
    hourly = forecast_data['forecast']['forecastday'][0]['hour'].map { |hour| hour['temp_c'] }
    average_temp = hourly.sum / hourly.size
    
    puts "Current weather in #{city}:"
    puts "Temperature: #{temperature}°C"
    puts "Humidity: #{humidity}%"
    puts "Conditions: #{weather_conditions}"
    puts "Average temperature for the next 24 hours: #{average_temp.round(2)}°C"
end
