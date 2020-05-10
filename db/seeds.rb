# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'rest-client'
require 'json'

def get_brewery_info_from_api
  #make the web request
  brewery_info = []
  i = 1
  19.times do 
    response_string = RestClient.get("https://api.openbrewerydb.org/breweries?by_state=california&per_page=50&page=#{i}")
    response_hash = JSON.parse(response_string)
    brewery_info << response_hash
    i += 1
  end
  brewery_info.flatten
end

get_brewery_info_from_api.each do |brew|
  Brewery.find_or_create_by(name: brew["name"].downcase, brewery_type: brew["brewery_type"], city: brew["city"].downcase, phone_number: brew["phone"])
end

city_array = ["Oakland", "Los Angeles", "San Francisco", "San Diego", "Sacramento", "Hollister"]
area_codes = ["310", "510", "415", "831", "213", "619", "916"]

1000.times do
  User.create(name: Faker::Name.name, city: city_array.sample, phone_number: area_codes.sample + Faker::PhoneNumber.subscriber_number(length: 7))
end

beers = ["IPA", "Pale Ale", "Cider", "Stout", "Porter", "Sour", "Kombucha", "Brown Ale", "Pilsner", "Bock", "Lager"]

5000.times do 
  Bookmark.create(brewery_id: Brewery.all.sample[:id], user_id: User.all.sample[:id], rating: rand(1..5), favorite: beers.sample)
end