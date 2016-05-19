# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(email: "me@mitchellzsmith.com", password: "1234")
User.create!(email: "krunkmitch@gmail.com", password: "1234")
jd = Band.create!(name: "Joy Division")
bh = Band.create!(name: "Beach House")
up = Album.create!(name: "Unknown Pleasures", band_id: jd.id, kind: "Studio")
cl = Album.create!(name: "Closer", band_id: jd.id, kind: "Studio")
td = Album.create!(name: "Teen Dream", band_id: bh.id, kind: "Studio")
bl = Album.create!(name: "Bloom", band_id: bh.id, kind: "Studio")
Track.create!(name: "Disorder", album_id: up.id, kind: "Regular", lyrics: "I've been waiting for a guide\nto come and take me by the hand")
Track.create!(name: "Norway", album_id: td.id, kind: "Regular", lyrics: "Norwaaaaaa\naaaaaaay")