# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

puts "Cleaning database"
#Review.destroy_all

puts "Creating reviews"

user_params = { first_name: "Bob", last_name: "Grills", username: "bobgyrlz",
                email: "bob.grills@gmail.com", password: '123123', password_confirmation: '123123' }
user = User.new(user_params)
user.save

# create_table "reviews", force: :cascade do |t|
#   t.integer "rating"
#   t.text "comment"
#   t.bigint "user_id", null: false
#   t.bigint "bbq_id", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["bbq_id"], name: "index_reviews_on_bbq_id"
#   t.index ["user_id"], name: "index_reviews_on_user_id"
# end
50.times do
  review = Review.create(
    comment: Faker::Restaurant.description,
    rating: rand(1..5),
    user_id: user.id,
    bbq_id: rand(1..15)
  )
  puts "Review for bbq: #{review.id} has been created"
end

# create_table "bbqs", force: :cascade do |t|
#   t.float "price"
#   t.string "title"
#   t.text "description"
#   t.string "location"
#   t.string "manufacturer"
#   t.bigint "user_id", null: false

15.times do
  bbq = Bbq.new(
    price: rand(1..50),
    title: Faker::Company.buzzword,
    description: Faker::TvShows::BigBangTheory.quote,
    location: Faker::Address.city,
    manufacturer: Faker::Company.name,
    user_id: user.id
  )
  bbq.save
  puts bbq.valid?
  puts "BBQ: #{bbq.id} has been created"
end

puts 'Completed'
