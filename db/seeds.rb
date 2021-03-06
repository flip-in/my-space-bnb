require 'faker'
require 'open-uri'

puts 'cleaning database'
Review.destroy_all
Booking.destroy_all
Spaceship.destroy_all
User.destroy_all

puts 'Creating users...'

User.create(name: "Luke Skywalker", email: 'test@test.com', password: 'password', bio: "I'm a Force-sensitive human male, was a legendary Jedi Master who fought in the Galactic Civil War during the reign of the Galactic Empire. ... I'm the son of Jedi Knight Anakin Skywalker and Senator Padmé Amidala, I was born along with my twin sister Leia in 19 BBY.")

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
    spaceship.photo.attach(io: file, filename: "#{spaceship['name']}.png", content_type: 'image/png' )

    user_email = Faker::Movies::StarWars.character.gsub(' ', '')
    spaceship.user = User.all.sample
    spaceship.save
  end
end

puts 'Creating bookings and reviews...'
first_spaceship = Spaceship.first
first_booking = Booking.new(start_date: Date.today - 100,
                            end_date: Date.today - 80,
                            status: "confirmed",
                            user: User.first, 
                            spaceship: first_spaceship)
first_booking.save

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
        stars: rand(3..5),
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
    path = File.expand_path("./db/images/#{rand(0..18)}.png")
    file = File.open(path)
    spaceship.photo.attach(io: file, filename: "#{spaceship['name']}.png", content_type: 'image/png' )

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
