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
    board = FactoryGirl.build(:board)
    assert board.valid?
  end

  test "boards without names are not valid" do
    board = FactoryGirl.build(:board, name: " ")
    assert_not board.valid?
  end

  test "boards without descriptions" do
    board = FactoryGirl.build(:board, description: " ")
    assert_not board.valid?
  end

  test "boards have supporters" do
    board = FactoryGirl.build(:board_with_supporter)
    assert_not_empty board.supporters
  end

  test "boards have owners" do
    board = FactoryGirl.create(:board_with_owner)
    assert board.owners.first.owner
  end
end
