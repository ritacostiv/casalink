# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "starting seeds"
Property.destroy_all
Collection.destroy_all
User.destroy_all
user = User.create!(email: "rita@casalink.com", password: "123456", first_name: "Rita", last_name: "Costiv")
