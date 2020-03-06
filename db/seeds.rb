require 'faker'
require 'open-uri'

puts 'cleaning database'
Review.destroy_all
Booking.destroy_all
Spaceship.destroy_all
User.destroy_all


puts 'Creating users...'

User.create(name: "Luke", email: 'test@test.com', password: 'password')

50.times do
  name = Faker::Movies::StarWars.character
  User.create(name: name, email: "#{name.gsub(' ', '')}@gmail.com", password: "password")
end

puts 'Creating spaceships...'

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
      description: Faker::Movies::StarWars.quote,
      price: rand(150..2_500),
      rating: rand(1..5)
    )
    path = File.expand_path("./db/images/#{rand(0..18)}.png")
    file = File.open(path)
    spaceship.photo.attach(io: file, filename:  "#{spaceship['name']}.png" )

    user_email = Faker::Movies::StarWars.character.gsub(' ', '')
    spaceship.user = User.all.sample
    spaceship.save
end


puts 'Creating bookings and reviews...'

# every spaceship has 2-3 bookings
#every booking has 3-5 reivews
spaceships = Spaceship.all

spaceships.each do |spaceship|
  rand(3..5).times do
    start = Date.today + rand(14)
    booking = Booking.new(
      start_date: start,
      end_date: start + 7,
      status: 'confirmed',
      user: User.all.sample,
      spaceship: spaceship
    )
  booking.save
  end

  spaceship.bookings.each do |booking|
    rand(1..2).times do
      review = Review.new(
        content: Faker::Restaurant.review,
        stars: rand(5),
        booking: booking,
        user: User.all.sample
      )
      review.save
    end
  end
end

puts 'creating seeds for test account...'

2.times do
  url = "https://swapi.co/api/starships/?format=json&page=1"
  puts "getting test account spaceships..."
  response = open(url).read

  spaceship_repo = JSON.parse(response)
  spaceships = spaceship_repo["results"]
  spaceships = spaceships.sample(2)
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
      rating: rand(1..5),
      user: User.first
    )
    spaceship.save
  end
end

puts 'Creating bookings for test bookings...'

User.first.spaceships.each do |spaceship|
  rand(2..3).times do
    start = Date.today + rand(4)
    test_booking = Booking.new(
      start_date: start,
      end_date: start + 7,
      status: 'pending',
      user: User.all.sample,
      spaceship: spaceship
    )
    test_booking.save
  end
end
