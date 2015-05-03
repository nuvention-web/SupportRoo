# == Schema Information
#
# Table name: tasks
#
#  id                :integer          not null, primary key
#  description       :string
#  start_time        :datetime
#  end_time          :datetime
#  task_type_id      :integer
#  board_id          :integer
#  shared            :boolean
#  accepted          :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  supporter_email   :string
#  supporter_message :string
#  supporter_name    :string
#  title             :string
#  user_id           :integer
#  completed?        :boolean          default("false")
#

require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test "tasks are accepted if they have a user" do
    accepted_task = create(:task)
    unaccepted_task = create(:task)

    user = create(:user)
    user.accept_task(accepted_task)

    assert accepted_task.accepted?, "User accepts a task, it is accepted"
    assert_not unaccepted_task.accepted?, "User is nil, not accepted"
  end

  test "tasks can be completed" do
    t = create(:task)
    assert_not t.completed?

    t.complete!
    assert t.completed?
  end

  test "tasks can be pinned and unpinned" do
    t = create(:task)
    assert_not t.pinned?

    t.pin!
    assert t.pinned?
    t.unpin!
    assert_not t.pinned?
  end

  test "pinned tasks show up first" do
    user = create(:user)
    5.times { user.tasks << create(:task) }

    user.tasks.last.pin!

    assert user.tasks.first.pinned?, "Pinned Task should show up first"
  end
end
