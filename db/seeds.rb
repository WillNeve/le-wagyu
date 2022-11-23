# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
require 'csv'
require 'open-uri'
# require_relative '/bbqseeds.csv'
# csv.open(filepath, "wb")

puts "Cleaning database"
Review.destroy_all
Bbq.destroy_all
# User.destroy_all

puts "Creating Users"

# user = User.create(first_name: 'Tom', last_name: 'Wagon', username: 'TomWagon', password: 'test', email: 'TomWagon@test.com')
# user1 = User.create(first_name: 'Wil', last_name: 'Wagon', username: 'WilWagon', password: 'test', email: 'WilWagon@test.com')
# user2 = User.create(first_name: 'Ben', last_name: 'Wagon', username: 'BenWagon', password: 'test', email: 'BenWagon@test.com')
# user3 = User.create(first_name: 'Vic', last_name: 'Wagon', username: 'VicWagon', password: 'test', email: 'VicWagon@test.com')

puts "Creating BBQs"

# create_table "bbqs", force: :cascade do |t|
#   t.float "price"
#   t.string "title"
#   t.text "description"
#   t.string "location"
#   t.string "manufacturer"
#   t.bigint "user_id", null: false
#   t.boolean "active"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["user_id"], name: "index_bbqs_on_user_id"
# end

# validates_presence_of :title, :price, :description, :location, :manufacturer
# validates :description, length: { minimum: 6, maximum: 200 }
# validates :title, length: { minimum: 6, maximum: 50 }


  filepath = "/root/code/Husemeyer/le-wagyu/db/bbqseeds.csv"
  user = User.first
  CSV.foreach(filepath, headers: :first_row) do |row|
  bbq = Bbq.create!(
    price: row[2],
    title: row[0],
    description: row[1],
    location: row[3],
    manufacturer: row[4],
    user: user
    # fuel_type: row[9],
    # cooking_area: row[10],
    # power: row[11],
    # weight: row[12],
    # type: row[13]
  )
  image_1 = URI.open(row[6])
  image_2 = URI.open(row[7])
  image_3 = URI.open(row[8])
  bbq.photos.attach(io: image_1, filename: "bbq_#{bbq.id}_1.png", content_type: "image/png")

  # bbq.save
  puts bbq.valid?
  puts "BBQ: #{bbq.id} has been created"
  end
# end
#   puts "Creating Reviews"

50.times do
  review = Review.create(
    comment: Faker::Restaurant.description,
    rating: rand(1..5),
    user_id: 1,
    bbq_id: rand(1..12)
  )
  puts "Review for bbq: #{review.id} has been created"
end

# 15.times do
#   bbq = Bbq.new(
#     price: rand(1..1000),
#     title: Faker::Company.buzzword,
#     description: Faker::TvShows::BigBangTheory.quote,
#     location: Faker::Address.city,
#     manufacturer: Faker::Company.name,
#     user_id: 1
#   )
#   bbq.save
#   puts bbq.valid?
#   puts "BBQ: #{bbq.id} has been created"
# end

puts 'Completed'
