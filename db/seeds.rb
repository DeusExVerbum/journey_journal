# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Users
# ------------------------------------------------------------------------------
user1 = User.create!(email: "user1@user1.com", password: "asdfasdf")


# Journeys
# ------------------------------------------------------------------------------
journey1 = Journey.create!(title: "Title1", description: "Description", user_id: user1.id)
journey2 = Journey.create!(title: "Title2", description: "Description", user_id: user1.id)
journey3 = Journey.create!(title: "Title3", description: "Description", user_id: user1.id)

# Entries
# ------------------------------------------------------------------------------

journey1.entries.create!(title: "Title", body: "Body", journey_id: journey1.id, user_id: user1.id)
journey2.entries.create!(title: "Title", body: "Body", journey_id: journey2.id, user_id: user1.id)
journey3.entries.create!(title: "Title", body: "Body", journey_id: journey3.id, user_id: user1.id)
