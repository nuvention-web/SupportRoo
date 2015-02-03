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

types = %w(General Food Transportation Visit Household Childcare Petcare Errands)

types.each do |t|
	TaskType.create(name: t)
end

Signup.create(email: "foo@bar.com", first_name: "Foo", last_name: "Bar")

