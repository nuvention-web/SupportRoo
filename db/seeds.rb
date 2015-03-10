categories = {food: %w(Groceries Delivery Prepared\ Food), 
              household: %w(Cleaning Laundry Supplies Yardwork Handyman Carwash),
              petcare: %w(Dogwalking Grooming Clean\ Up),
              childcare: %w(Care Babysit Pick-up/Drop-Off Homework\ Help),
              medical: %w(Care Nursing Physio Appointment),
              personal: %w(Grooming Hair/Nails Massage),
              love: %w(Spend\ Time Cheer\ Up Call)
}


categories.each do | cat, typeList |
  typeList.each do |type| 
    TaskType.create(name: type, category: cat)
  end
end

Signup.create(email: "foo@bar.com", first_name: "Foo", last_name: "Bar")
Board.create(email: "foo@bar.com", name: "Foo Bar")