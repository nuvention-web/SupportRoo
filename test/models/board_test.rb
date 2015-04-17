# == Schema Information
#
# Table name: boards
#
#  id          :integer          not null, primary key
#  email       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name        :string
#  description :string
#

require 'test_helper'

class BoardTest < ActiveSupport::TestCase
  test "valid board creation" do
    board = build(:board)
    assert board.valid?
  end

  test "boards without names are not valid" do
    board = build(:board, name: " ")
    assert_not board.valid?
  end

  test "boards without descriptions" do
    board = build(:board, description: " ")
    assert_not board.valid?
  end

  test "boards have supporters" do
    board = build(:board_with_supporter)
    assert_not_empty board.supporters
  end

  test "boards have owners" do
    board = create(:board_with_owner)
    assert board.owners.first.owner
  end

  test "supporters can be added to a board" do
    board = create(:board)
    user = create(:user)
    board.add_supporter(user)

    assert_includes board.users, user
  end

  test "owners can be added to boards" do
    board = create(:board)
    user = create(:user)
    board.add_owner(user)

    assert_includes board.users, user
    assert board.owners.any? { |s| s.user_id == user.id }
  end

  test "correct board owner" do
    user = create(:user)
    owner = create(:user)

    board = create(:board)
    user.add_board(board, false)
    owner.add_board(board, true)

    assert_not board.owned_by?(user)
    assert board.owned_by?(owner), 'Board should be owned by owner'
  end

  test "board has has accepted and unaccepted tasks" do
    board = create(:board_with_tasks)

    assert_difference -> { board.unaccepted_tasks.count }, -1 do
      board.tasks.first.update_attribute(:user_id, 1)
    end
  end

  # test "correct tasks accepted by a user" do
  #   user1 = create(:user) #doesn't have tasks on board
  #   user2 = create(:user) #has a task on board
  #   user3 = create(:user) #has a task on a different board

  #   board1 = create(:board)
  #   board2 = create(:board)

  #   user1.add_board(board1)
  #   user2.add_board(board1)
  #   user3.add_board(board2)

  #   assert

  # end
end
