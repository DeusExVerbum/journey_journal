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
journey1 = Journey.create!(title: "A Local Escape", description: "We had to get away. There was too much nothingness happening in our small town. The surrounding area was enchanting.", user_id: user1.id)
journey2 = Journey.create!(title: "European Vacation 2014", description: "Prague, Berlin, Venice, Amsterdam. So many places I've read about, and I've almost caught 'em all!", user_id: user1.id)
journey3 = Journey.create!(title: "Nights Beneath Stars", description: "A night in Yosemite park.", user_id: user1.id)

# Entries
# ------------------------------------------------------------------------------
puts "Creating Entries"

# Journey 1
e1 = journey1.entries.create!(title: "Chico", body: "Body", journey_id: journey1.id, user_id: user1.id, latitude: 39.74, longitude: -121.8356)
c1 = Comment.build_from(e1, user1.id, "This is my first comment!")
c1.save
c2 = Comment.build_from(e1, user1.id, "This is my second comment!")
c2.save

e2 = journey1.entries.create!(title: "Oroville", body: "Body", journey_id: journey3.id, user_id: user1.id, latitude: 39.5167, longitude: -121.55)
c3 = Comment.build_from(e2, user1.id, "This is my third comment!")
c3.save
# NOTE: back to e1
c4 = Comment.build_from(e1, user1.id, "This is my fourth comment!")
c4.save
c4.move_to_child_of(c1)
c5 = Comment.build_from(e1, user1.id, "This is my fifth comment!")
c5.save
c5.move_to_child_of(c1)
c6 = Comment.build_from(e1, user1.id, "This is my sixth comment!")
c6.save
c6.move_to_child_of(c5)

journey1.entries.create!(title: "Paradise", body: "Body", journey_id: journey2.id, user_id: user1.id, latitude: 39.7597, longitude: -121.6214)

# Journey 2
journey2.entries.create!(title: "Germany", body: "Body", journey_id: journey2.id, user_id: user1.id, latitude: 52.51, longitude: 13.38)

# Journey 3
journey3.entries.create!(title: "Quebec", body: "Body", journey_id: journey3.id, user_id: user1.id, latitude: 46.8167, longitude: -71.2167)




puts "Done seeding the database!"
