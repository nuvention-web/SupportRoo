categories = {food: %w(Groceries Take\ Out Meal\ Delivery),
              household: %w(Cleaning Laundry Supplies Yardwork Handyman Carwash Snow\ Shoveling Other),
              transportation: %w(Pick-Up/Drop-Off Errands Other),
              petcare: %w(Dogwalking Grooming Clean\ Up Other),
              childcare: %w(Babysit Homework\ Help Other),
              errands: %w(Pick-Up/Drop-Off Carpool Other),
              medical: %w(Care Nursing Physio Other),
              personal: %w(Grooming Massage Spend\ Time Other),
              custom: %w(Custom)
             }


categories.each do | cat, typeList |
  typeList.each do |type|
    TaskType.create(name: type, category: cat)
  end
end

Board.create(email: "foo@bar.com", name: "Foo Bar")
