# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Cat.create!(:age => 4, :birth_date => "01/01/1990", :color => "black", :name => "Sennacy", :sex => "F" )
Cat.create!(:age => 3, :birth_date => "01/04/1993", :color => "white", :name => "Mitch", :sex => "M" )
Cat.create!(:age => 5, :birth_date => "02/02/1996", :color => "grey", :name => "Roma", :sex => "M" )

CatRentalRequest.create!(:cat_id => 1, :start_date => 10.days.ago, :end_date => Time.now)
CatRentalRequest.create!(:cat_id => 1, :start_date => 20.days.ago, :end_date => 11.days.ago)
# CatRentalRequest.create!(:cat_id => 1, :start_date => 15.days.ago, :end_date => 12.days.ago)