require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  def setup
    @user = create(:user)
    @board = create(:board_with_owner)
    @invite = create(:invite, board: @board)
    @t = create(:task, board: @board)
  end

  test "notify supporter" do
    @user.accept_task(@t, "message")
    # Send the email, then test that it got queued
    email = UserMailer.notify_supporter(@t).deliver_now
    assert_not ActionMailer::Base.deliveries.empty?

    # Test the attrs of the sent email contain what we expect them to
    assert_equal ['suprooteam@gmail.com'], email.from
    assert_equal [@user.email], email.to
    assert_match /thank you/i, email.subject
  end

  test "notify owners" do
    @user.accept_task(@t, "message")
    # Send the email, then test that it got queued
    email = UserMailer.notify_board_owners(@t).deliver_now
    assert_not ActionMailer::Base.deliveries.empty?

    # Test the attrs of the sent email contain what we expect them to
    assert_equal ['suprooteam@gmail.com'], email.from
    assert_includes email.to, @t.board.creator.email
    assert_match /signed up/i, email.subject
    assert_match /#{@t.user.first_name}/i, email.subject
  end

  test "send invites" do
    email = UserMailer.invite_user(@invite).deliver_now
    assert_not ActionMailer::Base.deliveries.empty?

    # Test the attrs of the sent email contain what we expect them to
    assert_equal ['suprooteam@gmail.com'], email.from
    assert_equal [@invite.email], email.to
    assert_match /invited/i, email.subject
    assert_match /#{@invite.board.creator.first_name}/i, email.subject
  end

  test "notify owners when task is completed" do
    @user.accept_task(@t, "message")
    email = UserMailer.notify_owners_of_completion(@t).deliver_now
    assert_not ActionMailer::Base.deliveries.empty?

    # Test the attrs of the sent email contain what we expect them to
    assert_equal ['suprooteam@gmail.com'], email.from
    assert_includes email.to, @t.board.creator.email
    assert_match /completed/i, email.subject
    assert_match /#{@invite.board.creator.first_name}/i, email.subject
  end


end
