# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = User.create([{name: "Mitch"}, {name: "Tom"}, {name: "Sennacy"}])
poll1 = Poll.create(author: users.first, title: "What do you like about cats?")
poll2 = Poll.create(author: users.second, title: "What are your favorite rat-killing methods?")
q1 = Question.create(poll: poll1, text: "Do you like their fur?")
q2 = Question.create(poll: poll1, text: "Do you like their ears?")
q3 = Question.create(poll: poll1, text: "Do you like their tails?")
q4 = Question.create(poll: poll2, text: "Do you use poison?")
q5 = Question.create(poll: poll2, text: "Do you drown them?")
q6 = Question.create(poll: poll2, text: "Does your cat take care of them for you?")
ac1 = AnswerChoice.create([{question: q1, text: "yes"}, {question: q1, text: "no"}, {question: q1, text: "I'm allergic"}])
ac2 = AnswerChoice.create([{question: q2, text: "yes"}, {question: q2, text: "no"}, {question: q2, text: "I'm allergic"}])
ac3 = AnswerChoice.create([{question: q3, text: "yes"}, {question: q3, text: "no"}, {question: q3, text: "I'm allergic"}])
ac4 = AnswerChoice.create([{question: q4, text: "yes"}, {question: q4, text: "no"}, {question: q4, text: "I'm allergic"}])
ac5 = AnswerChoice.create([{question: q5, text: "yes"}, {question: q5, text: "no"}, {question: q5, text: "I'm allergic"}])
ac6 = AnswerChoice.create([{question: q6, text: "yes"}, {question: q6, text: "no"}, {question: q6, text: "I'm allergic"}])
response1 = Response.create(respondent: users[1], answer_choice: ac1[2])
response2 = Response.create(respondent: users[1], answer_choice: ac2[2])
response3 = Response.create(respondent: users[1], answer_choice: ac3[2])
