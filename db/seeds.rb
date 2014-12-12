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
puts "Creating Users..."
user1 = User.create!(username: "Martin", email: "martin@jj.com", password: "asdfasdf")
user2 = User.create!(username: "Cash", email: "cash@jj.com", password: "asdfasdf")
user3 = User.create!(username: "Anne", email: "anne@jj.com", password: "asdfasdf")
user4 = User.create!(username: "Sam", email: "sam@jj.com", password: "asdfasdf")
user5 = User.create!(username: "Rainy", email: "rainy@jj.com", password: "asdfasdf")


# Journeys
# ------------------------------------------------------------------------------
puts "Creating Journeys..."
journey1 = Journey.create!(
  title: "Cash's Trip",
  description: "We had to get away. There was too much nothingness happening in our small town. The surrounding area was enchanting.",
  user_id: user2.id)
journey2 = Journey.create!(
  title: "Martin's Trip",
  description: "Description",
  user_id: user1.id)
#journey3 = Journey.create!(
  #title: "Anne's Trip",
  #description: "A night in Yosemite park.",
  #user_id: user3.id)

# Entries
# ------------------------------------------------------------------------------
puts "Creating Entries..."

# Journey 1
entries = []
entries.push(
  journey1.entries.create!(
    title: "Amsterdam",
    body: File.open('db/entry_bodies/01-amsterdam.txt', 'r').read,
    journey_id: journey1.id,
    user_id: user2.id,
    latitude: 52.3661529,
    longitude: 4.8965645)
)
entries.push(
  journey1.entries.create!(
    title: "Maastricht",
    body: File.open('db/entry_bodies/02-maastricht.txt', 'r').read,
    journey_id: journey1.id,
    user_id: user2.id,
    latitude: 50.844511,
    longitude: 5.696401)
)
entries.push(
  journey1.entries.create!(
    title: "Bruges",
    body: File.open('db/entry_bodies/03-bruges.txt', 'r').read,
    journey_id: journey1.id,
    user_id: user2.id,
    latitude: 51.199529,
    longitude: 3.225273)
)
entries.push(
  journey1.entries.create!(
    title: "Ypres",
    body: File.open('db/entry_bodies/04-ypres.txt', 'r').read,
    journey_id: journey1.id,
    user_id: user2.id,
    latitude: 50.848636,
    longitude: 2.877839)
)
entries.push(
  journey1.entries.create!(
    title: "Paris",
    body: File.open('db/entry_bodies/05-paris.txt', 'r').read,
    journey_id: journey1.id,
    user_id: user2.id,
    latitude: 48.861584,
    longitude: 2.323650)
)

journey2.entries.create!(
  title: "Australia",
  body: "To demonstrate home page randomization",
  journey_id: journey2.id,
  user_id: user1.id,
  latitude: -30.15801,
  longitude: 149.72901)

journey2.entries.create!(
  title: "China",
  body: "To demonstrate home page randomization",
  journey_id: journey2.id,
  user_id: user1.id,
  latitude: 39.13423,
  longitude: 108.41047)

journey2.entries.create!(
  title: "Brazil",
  body: "To demonstrate home page randomization",
  journey_id: journey2.id,
  user_id: user1.id,
  latitude: -2.27613,
  longitude: -55.25308)

# Comments
# ------------------------------------------------------------------------------
puts "Creating Comments..."

def comment_an_entry(entry, user2, user3, user4, user5)
  c1 = Comment.build_from(entry, user2.id, "Great story")
  c1.save

  c2 = Comment.build_from(entry, user3.id, "Could have used more dinosaurs. Work on that.")
  c2.save

  c3 = Comment.build_from(entry, user2.id, "There were plenty of dinosaurs. Lay off OP")
  c3.save
  c3.move_to_child_of(c2)

  c4 = Comment.build_from(entry, user3.id, "Who are you, the dinosaur police?")
  c4.save
  c4.move_to_child_of(c3)

  c5 = Comment.build_from(entry, user4.id, "Tell me more!")
  c5.save

  c6 = Comment.build_from(entry, user5.id, "^this")
  c6.save
  c6.move_to_child_of(c5)
end

entries.each do |e|
  comment_an_entry(e, user2, user3, user4, user5)
end

puts "Done seeding the database!"
