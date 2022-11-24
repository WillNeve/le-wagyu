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

puts "Creating Users"

puts "Creating BBQs"

user_params = { first_name: "Bob", last_name: "Grills", username: "bobgyrlz",
                email: "bob.grills@gmail.com", password: '123123', password_confirmation: '123123' }
user = User.new(user_params)
user.save


  filepath = File.join(Rails.root, 'db', 'bbqseeds.csv')
  user = User.first

  CSV.foreach(filepath, headers: :first_row) do |row|
    bbq = Bbq.create!(
      price: row[2].gsub('“', '').gsub('”', '').to_f,
      title: row[0].gsub('“', '').gsub('”', ''),
      description: row[1].gsub('“', '').gsub('”', ''),
      location: row[3].gsub('“', '').gsub('”', ''),
      manufacturer: row[4].gsub('“', '').gsub('”', ''),
      user: user,
      fuel_type: row[9].gsub('“', '').gsub('”', ''),
      cooking_area: row[10].gsub('“', '').gsub('”', ''),
      power: row[11].gsub('“', '').gsub('”', ''),
      weight: row[12].gsub('“', '').gsub('”', ''),
      style_type: row[13].gsub('“', '').gsub('”', ''),
      address: row[14].gsub('“', '').gsub('”', '')
    )

    image_1 = URI.open(row[6].gsub('“', '').gsub('”', ''))
    image_2 = URI.open(row[7].gsub('“', '').gsub('”', ''))
    image_3 = URI.open(row[8].gsub('“', '').gsub('”', ''))

    bbq.photos.attach(io: image_1, filename: "bbq_#{bbq.id}_1.png", content_type: "image/jpg")
    bbq.photos.attach(io: image_2, filename: "bbq_#{bbq.id}_2.png", content_type: "image/jpg")
    bbq.photos.attach(io: image_3, filename: "bbq_#{bbq.id}_3.png", content_type: "image/jpg")

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
    bbq_id: rand(1..16)
  )
  puts "Review for bbq: #{review.id} has been created"
end

puts 'Completed'
