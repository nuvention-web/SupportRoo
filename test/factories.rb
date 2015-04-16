FactoryGirl.define do
  factory :user do
    email "foo@bar.com"
    password "foobar12"
    password_confirmation "foobar12"
    after(:build) do |user|
      user.supporters << FactoryGirl.build(:supporter, user: user)
    end
  end

  factory :user_owning_board, class: "User" do
    email "owner@bar.com"
    password "foobar12"
    password_confirmation "foobar12"
    after(:build) do |user|
      user.supporters << FactoryGirl.build(:owner, user: user)
    end
  end

  factory :owner, class: "Supporter" do |supporter|
    supporter.association :user
    supporter.association :board
    owner true
  end

  factory :supporter do |supporter|
    supporter.association :user
    supporter.association :board
    owner false
  end

  factory :board do
    name "A cool Support Board"
    description "the coolest"
  end

  factory :board_with_owner, class: "Board" do
    name "A board with a supporter"
    description "foo"
    after(:build) do |board|
      board.supporters << FactoryGirl.build(:owner, board: board)
    end
  end

  factory :board_with_supporter, class: "Board" do
    name "A board with a supporter"
    description "foo"
    after(:build) do |board|
      board.supporters << FactoryGirl.build(:supporter, board: board)
    end
  end
end
