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
User.destroy_all
Collection.destroy_all
Property.destroy_all
user = User.create!(email: "miguel@casalink.com", password: "123456")
collection = Collection.create!(name: "Alvalade", user: user)
property1 = Property.create!(name: "T4 for sale",
                            price: "865.000€",
                            url: "https://www.idealista.pt/imovel/33353664/",
                            address: "Avenida dos Estados Unidos da America",
                            typology: "T4",
                            size: "216m²",
                            elevator: true,
                            garage: false,
                            collection: collection)

puts "#{property1.name} created"

property2 = Property.create!(name: "T3 for sale",
                            price: "620.000€",
                            url: "https://www.idealista.pt/imovel/34040390/",
                            address: "Avenida Gago Coutinho",
                            typology: "T3",
                            size: "169m²",
                            elevator: true,
                            garage: false,
                            collection: collection)

puts "#{property2.name} created"

property3 = Property.create!(name: "Amazing penthouse",
                            price: "855.000€",
                            url: "https://www.idealista.pt/imovel/33961824/",
                            address: "Avenida da Republica",
                            typology: "T5",
                            size: "190m²",
                            elevator: true,
                            garage: true,
                            collection: collection)

puts "#{property3.name} created"
puts "seeding finished"
