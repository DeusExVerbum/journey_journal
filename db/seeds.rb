# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Seeding the database"

# Users
# ------------------------------------------------------------------------------
puts "Creating Users"
user1 = User.create!(email: "admin@admin.com", password: "asdfasdf")


# Journeys
# ------------------------------------------------------------------------------
puts "Creating Journeys"
journey1 = Journey.create!(title: "Title1", description: "Description", user_id: user1.id)
journey2 = Journey.create!(title: "Title2", description: "Description", user_id: user1.id)
journey3 = Journey.create!(title: "Title3", description: "Description", user_id: user1.id)

# Entries
# ------------------------------------------------------------------------------
puts "Creating Entries"
journey1.entries.create!(title: "Title 1", body: "Body", journey_id: journey1.id, user_id: user1.id, latitude: -34.392, longitude: 150.649)
journey1.entries.create!(title: "Title 2", body: "Body", journey_id: journey2.id, user_id: user1.id, latitude: -34.395, longitude: 150.640)
journey1.entries.create!(title: "Title 3", body: "Body", journey_id: journey3.id, user_id: user1.id, latitude: -34.397, longitude: 150.644)

puts "Done seeding the database!"
