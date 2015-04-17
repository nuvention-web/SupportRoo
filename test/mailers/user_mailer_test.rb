require 'test_helper'
 
class UserMailerTest < ActionMailer::TestCase
  def setup
    @user = create(:user)
    @t = create(:task)
  end

  test "notify supporter" do
    @user.accept_task(@t, "message")
    # Send the email, then test that it got queued
    email = UserMailer.notify_supporter(@t).deliver_now
    assert_not ActionMailer::Base.deliveries.empty?
 
    # Test the attrs of the sent email contain what we expect them to
    assert_equal ['suprooteam@gmail.com'], email.from
    assert_equal [@user.email], email.to
    assert_equal "Thanks for signing up for a task on SupportRoo", email.subject
  end

  test "notify owners" do
    @user.accept_task(@t, "message")
    # Send the email, then test that it got queued
    email = UserMailer.notify_board_owners(@t).deliver_now
    assert_not ActionMailer::Base.deliveries.empty?
 
    # Test the attrs of the sent email contain what we expect them to
    assert_equal ['suprooteam@gmail.com'], email.from
    assert_equal @t.board.owners.map{ |o| User.find(o.user_id).email } , email.to
    assert_equal "#{@t.supporter_name} just signed up for a task on your board!", email.subject
  end
end