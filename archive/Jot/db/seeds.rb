# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u1 = User.create!({email: "me@mitchellzsmith.com", username: "mitch", password: "123456"})
u2 = User.create!({email: "foo@foo.com" , username: "foo", password: "123456"})

10.times do
  User.create!({email: Faker::Internet.email, username: Faker::Name.last_name, password: "123456"})
end

# creating these is ESSENTIAL to user being able to swap out syntaxes
s1 = Syntax.create!(highlighting: "plaintext", title:"Plaintext")
s2 = Syntax.create!(highlighting: "text/x-ruby", title:"Ruby")
Syntax.create!({highlighting: "text/x-sql", title: "SQL"})
Syntax.create!({highlighting: "text/css", title: "CSS"})
Syntax.create!({highlighting: "text/javascript", title: "JavaScript"})
Syntax.create!({highlighting: "text/html", title: "HTML"})

p1 = Page.new({title: "Test1", is_public: true, password: "", syntax_id: s1.id})
p1.url_fragment = "foo"
p1.save!
p1.versions.create!({body: "1 Some Text", number: 1})
p1.versions.create!({body: "1 Some More Text", number: 2})

p2 = Page.new({title: "Test2", is_public: true, password: "123456", syntax_id: s1.id})
p2.url_fragment = "bar"
p2.save!
p2.versions.create!({body: "2 Some Text", number: 1})
p2.versions.create!({body: "2 Some More Text", number: 2})

p3 = Page.new({title: "Test3", is_public: false, password: "", syntax_id: s1.id})
p3.url_fragment = "baz"
p3.owner_id = u1.id
p3.save!

10.times do |i|
  p3.versions.create!({body: "#{i} Some Text", number: i + 1})
end

10.times do |i|
  page = Page.new({title: "Test#{i}", is_public: true, password: "", syntax_id: s1.id})
  page.url_fragment = TokenPhrase.generate(numbers: false)
  page.save!
  page.versions.create!({body: "{i} Some Text", number: 1})
  page.versions.create!({body: "{i} Some More Text", number: 2})
  Favorite.create!({ user_id: u1.id, page_id: page.id })
end

Share.create!({page_id: p3.id, sharer_id: u1.id, sharee_id: u2.id})

c1 = Comment.create!({body: "Nice", page_id: p1.id, owner_id: u1.id})
c2 = Comment.create!({body: "Cool", page_id: p1.id, owner_id: u2.id})
c3 = Comment.create!({body: "Nice", page_id: p2.id, owner_id: u1.id})
c4 = Comment.create!({body: "Cool", page_id: p2.id, owner_id: u2.id})
c5 = Comment.create!({body: "Nice", page_id: p3.id, owner_id: u1.id})
c6 = Comment.create!({body: "Cool", page_id: p3.id, owner_id: u2.id})