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
    user = build(:user)
    assert user.valid?
  end

  test "users without emails are not valid" do
    user = build(:user)
    user.email = "   "
    assert_not user.valid?
  end

  test "no two users can have same email" do
    user = create(:user)
    user2 = build(:user, email: user.email.upcase)
    assert_not user2.valid?
  end

  test "users have boards" do
    user = create(:user)
    assert_not_empty user.boards
  end

  test "users can own boards" do
    user = create(:user_owning_board)
    assert_not_empty user.owned_boards
  end

  test "user can accept a task" do 
    user = build(:user)
    t = build(:task)

    user.accept_task(t)
    assert_includes user.tasks, t
  
  end
end
