# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'csv'
require 'open-uri'

# puts "Cleaning database"
# Review.destroy_all
# Bbq.destroy_all
# User.destroy_all

# puts "Creating Users"

# # always make bob grills 💖

user_params = { first_name: "Bob", last_name: "Grills", username: "bobgyrlz",
                email: "bob.grills@gmail.com", password: '123123', password_confirmation: '123123' }
user = User.new(user_params)
user.save
puts "Bob Grills created 🔥"

10.times do # lets make 10 different users for reviews and bbqs
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  username = "#{first_name}-#{last_name}"
  password = '123123'
  password_confirmation = password
  email = "#{first_name}.#{last_name}@test.com"
  user_params = { first_name:, last_name:, username:,
                  email:, password:, password_confirmation: }
  user = User.create(user_params)
  puts "User: #{user.id} created"
end

puts "Creating BBQs"

filepath = File.join(Rails.root, 'db', 'bbqseeds.csv') # have to give path to csv from root of rails app

CSV.foreach(filepath, headers: :first_row) do |row|
  user = User.find(rand(1..(User.all.length - 1))) # assigns a random user for each bbq listing
  bbq = Bbq.create!(
    price: row[2].gsub('“', '').gsub('”', '').to_f,
    title: row[0].gsub('“', '').gsub('”', ''),
    description: row[1].gsub('“', '').gsub('”', ''),
    location: row[14].gsub('“', '').gsub('”', ''),
    manufacturer: row[4].gsub('“', '').gsub('”', ''),
    user:, # <-- when you have a variable the same name as the key and leave the value empty it automatically assigns it
    fuel_type: row[9].gsub('“', '').gsub('”', ''),
    cooking_area: row[10].gsub('“', '').gsub('”', ''),
    power: row[11].gsub('“', '').gsub('”', ''),
    weight: row[12].gsub('“', '').gsub('”', ''),
    style_type: row[13].gsub('“', '').gsub('”', ''),
    address: row[3].gsub('“', '').gsub('”', '')
  )

  image1 = URI.open(row[6].gsub('“', '').gsub('”', ''))
  image2 = URI.open(row[7].gsub('“', '').gsub('”', ''))
  image3 = URI.open(row[8].gsub('“', '').gsub('”', ''))

  bbq.photos.attach(io: image1, filename: "bbq_#{bbq.id}_1.png", content_type: "image/jpg")
  bbq.photos.attach(io: image2, filename: "bbq_#{bbq.id}_2.png", content_type: "image/jpg")
  bbq.photos.attach(io: image3, filename: "bbq_#{bbq.id}_3.png", content_type: "image/jpg")

  puts bbq.valid?
  puts "BBQ: #{bbq.id} has been created"
end

puts "Creating Reviews"
filepath2 = File.join(Rails.root, 'db', 'reviewseeds.csv') # have to give path to csv from root of rails app
CSV.foreach(filepath2, headers: :first_row) do |row|
  user = User.find(rand(1..(User.all.length - 1))) # assigns a random user for each bbq listing
  bbq = Bbq.find(rand(1..(Bbq.all.length - 1)))
  review = Review.create(
    comment: row[3].gsub('“', '').gsub('”', ''),
    rating: row[0].gsub('“', '').gsub('”', ''),
    user:,
    bbq:,
  )
  puts "Review for bbq: #{review.id} has been created"
end

puts 'Completed'
