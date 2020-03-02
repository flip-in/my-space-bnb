require 'faker'
require 'open-uri'

puts 'cleaning database'
Spaceship.destroy_all
User.create(email: 'test@test.com', password: 'password' )

puts 'Creating spaceships...'

# get the right data from the api url
(1..2).each do |page|
  url = "https://swapi.co/api/starships/?format=json&page=#{page}"
  puts "getting spaceships..."
  response = open(url).read

  spaceship_repo = JSON.parse(response)
  spaceships = spaceship_repo["results"]

  spaceships.each do |spaceship|
    spaceship = Spaceship.new(
      name: spaceship['name'],
      passengers: spaceship['passengers'],
      length: spaceship['length'],
      speed: spaceship['max_atmosphering_speed'],
      spaceship_class: spaceship['starship_class'],
      crew: spaceship['crew'],
      location: Faker::Address.city,
      manufacturer: spaceship['manufacturer'],
      description: Faker::Movies::StarWars.quote
    )
    user_email = Faker::Movies::StarWars.character.gsub(' ', '')
    puts 'Email is ' + user_email
    user = User.new(email: "#{user_email}@gmail.com", password: 'password')
    if !(user.save)
      user.email = "#{user_email}#{rand(1..9)}@gmail.com"
    end
    spaceship.user = user
    spaceship.save
  end
end

# populate a spaceship model with
