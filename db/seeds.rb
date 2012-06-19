# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
users = User.create([{ :username => 'admin', :email => 'test@test.com', :password => 'advitor', :password_confirmation => 'advitor', :role => 'Admin', :status => 1}])

seo = Seo.create([{ :meta_description => 'no description', :meta_keywords => 'no keyword', :meta_author => 'no author'}])


