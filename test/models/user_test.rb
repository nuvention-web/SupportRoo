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
    user = create(:user)
    board = create(:board)
    user.add_board(board, true)

    assert_includes user.owned_boards, board
  end

  test "user can accept a task" do
    user = create(:user)
    t = create(:task)
    user.accept_task(t, "message")
    assert_includes user.tasks, t
    assert_not_nil t.supporter_message
  end

  test "user has tasks on a particular board" do
    user = create(:user)
    board = create(:board)
    task = create(:task, board: board)
    task2 = create(:task)

    user.accept_task(task)
    assert_includes user.tasks_from_board(board), task
    assert_not_includes user.tasks_from_board(board), task2
  end
end
