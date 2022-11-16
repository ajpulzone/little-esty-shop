require "httparty"
require "pry"

response = HTTParty.get("https://date.nager.at/api/v3/NextPublicHolidays/US")
parsed = JSON.parse(response.body, symbolize_names: true)
