FactoryGirl.define do
  factory :user do
    email "foo@bar.com"
    password "foobar12"
    password_confirmation "foobar12"
  end
end
