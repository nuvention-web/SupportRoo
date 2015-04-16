# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "users with valid emails are valid" do
    user = FactoryGirl.build(:user)
    assert user.valid?
  end

  test "users without emails are not valid" do
    user = FactoryGirl.build(:user)
    user.email = "   "
    assert_not user.valid?
  end

  test "no two users can have same email" do
    user = FactoryGirl.build(:user)
    user.save
    user2 = FactoryGirl.build(:user, email: user.email.upcase)
    assert_not user2.valid?
  end

  test "users have boards" do
    user = FactoryGirl.create(:user)
    assert_not_empty user.boards
  end

  test "users can own boards" do
    user = FactoryGirl.create(:user_owning_board)
    assert_not_empty user.owned_boards
  end
end
