# == Schema Information
#
# Table name: invites
#
#  id         :integer          not null, primary key
#  board_id   :integer
#  code       :string
#  claimed    :boolean          default("false")
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_invites_on_code  (code)
#

require 'test_helper'

class InviteTest < ActiveSupport::TestCase
  test "should be unclaimed by default" do
    invite = build(:invite)    
    assert_not invite.claimed
  end

  test "should add board code before save" do
    invite = build(:invite)    
    assert_not invite.code.present?

    invite.save
    assert invite.code.present?
  end

  test "should not save without an email" do
    invite = build(:invite, email:'')
    assert_not invite.valid?
    invite.email = 'foo@bar.com'
    assert invite.valid?
  end

  test "should not save without a board" do
    invite = build(:invite, board_id: nil)
    assert_not invite.valid?
  end

  test "should not save with invalid email" do
    invite = build(:invite, email: 'foobar.com')
    assert_not invite.valid?
  end

  test "should save with valid email" do
    invite = build(:invite, email: 'foo@bar.com')
    assert invite.valid?
  end
end
