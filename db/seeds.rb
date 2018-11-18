# This file should contain all the record creation needed to seed the database with its default values.
<<<<<<< HEAD
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
=======
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :first_name => 'First', :last_name => 'Last', :email => 'user@example.com', :password => 'please', :password_confirmation => 'please'
puts 'New user created: ' << "#{user.first_name} #{user.last_name}"
>>>>>>> 528a84ac36f9ee8ae5ac92ad60e3b15c99db9827
