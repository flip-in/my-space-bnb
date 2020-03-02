require 'faker'
require 'open-uri'

puts 'cleaning database'
Spaceship.destroy_all
User.create(email: 'me@me.com', password: 'password' )
User.create(email: 'you@you.com', password: 'password' )

puts 'Creating spaceships...'

# get the right data from the api url
(1..2).each do |page|
  url = "https://swapi.co/api/starships/?format=json&page=#{page}"
  puts "getting spaceships..."
  response = open(url).read

  spaceship_repo = JSON.parse(response)
  spaceships = spaceship_repo["results"]

  spaceships.each do |spaceship|
    Spaceship.create(
      name: spaceship['name'],
      passengers: spaceship['passengers'],
      length: spaceship['length'],
      speed: spaceship['max_atmosphering_speed'],
      spaceship_class: spaceship['starship_class'],
      crew: spaceship['crew'],
      location: Faker::Address.city,
      manufacturer: spaceship['manufacturer'],
      description: Faker::Movies::StarWars.quote,
      user: User.all.sample
    )
  end
end

# populate a spaceship model with
