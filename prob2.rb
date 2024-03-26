require 'httparty'
require 'json'

api_key = '1e9f00875e5af7a6e626a513'
currency = 'USD'
target = 'VND'

amount = 100


response = HTTParty.get(url = "https://v6.exchangerate-api.com/v6/#{api_key}/pair/#{currency}/#{target}")


if response.code == 200
    data = JSON.parse(response.body)
    if data["result"] == "success"

        exchange_rate = data["conversion_rate"]
        converted_amount = amount * exchange_rate

        puts "#{amount} #{currency} is equal to #{converted_amount.round(2)} #{target}."
    end
end
 