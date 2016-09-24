# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(provider: 'google_oauth2', name: 'sandeep kapil', uid: 'na', email: 'kapilsandeep7@gmail.com', status: true, role =>1)
User.create(provider: 'google_oauth2', name: 'Anil', uid: 'na', email: 'gapianilabs@gmail.com', status: true, role =>1)
