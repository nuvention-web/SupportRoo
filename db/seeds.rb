# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#  name                :string
#  category            :string
#  default_description :string

types = { food: %w(Groceries Delivery Prepared\ Food), 
household: %w(Cleaning Laundry Supplies Yardwork Handyman Carwash),
petcare: %w(Dogwalking Grooming Clean\ Up),
child: %w(Care Babysit Pick-up/Drop-Off Homework\ Help),
home: %w(Medical\ Care Nursing Physio),
personal: %w(Grooming Hair/Nails Massage),
love: %w(Spend\ Time Cheer\ Up Call)
}


types.each do | k, v |
	TaskType.create(name: v, category: k)
end

Signup.create(email: "foo@bar.com", first_name: "Foo", last_name: "Bar")
Board.create(email: "foo@bar.com", name: "Foo Bar")