require 'pry-byebug'
require 'faker'
require 'open-uri'

puts 'cleaning database'
Review.destroy_all
Booking.destroy_all
Spaceship.destroy_all
User.destroy_all


puts 'Creating users...'

User.create(email: 'test@test.com', password: 'password' )

50.times do
  User.create(email: Faker::Internet.email, password: "password")
end

puts 'Creating spaceships...'

# get the right data from the api url
(1..2).each do |page|
  url = "https://swapi.co/api/starships/?format=json&page=#{page}"
  puts "getting spaceships..."
  response = open(url).read

  spaceship_repo = JSON.parse(response)
  spaceships = spaceship_repo["results"]
# byebug
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
      description: Faker::Movies::StarWars.quote,
      price: rand(150..2_500),
      rating: rand(1..5)
    )
    user_email = Faker::Movies::StarWars.character.gsub(' ', '')
    spaceship.user = User.all.sample
    spaceship.save
  end
end


puts 'Creating bookings...'
20.times do
first_booking = Booking.new(start_date: Date.today-rand(5000), end_date: Date.today + rand(5000), status: 'confirmed')
spaceship = Spaceship.all.sample
booking_user = User.find(spaceship.user.id + 1)
if booking_user.nil?
  booking_user = User.find(spaceship.user.id - 1)
end
first_booking.user = booking_user
first_booking.spaceship = spaceship
first_booking.save!
end
# populate a spaceship model with
