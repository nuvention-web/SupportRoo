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

class SupporterTest < ActiveSupport::TestCase
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

  test "correct board owner" do
    user = create(:user)
    owner = create(:user)

    board = create(:board)
    user.add_board(board, false)
    owner.add_board(board, true)

    assert_not board.owned_by(user)
    assert board.owned_by(owner), 'Board should be owned by owner'

  end
end
