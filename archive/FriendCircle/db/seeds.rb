# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(email: "mitch@mitch.com", password: "123456")
User.create!(email: "paris@paris.com", password: "123456")
User.create!(email: "sennacy", password: "123456")
User.create!(email: "bob", password: "123456")