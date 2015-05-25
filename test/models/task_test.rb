# == Schema Information
#
# Table name: tasks
#
#  id                    :integer          not null, primary key
#  description           :string
#  start_time            :datetime
#  end_time              :datetime
#  task_type_id          :integer
#  board_id              :integer
#  shared                :boolean
#  accepted              :boolean
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  supporter_email       :string
#  supporter_message     :string
#  supporter_name        :string
#  title                 :string
#  user_id               :integer
#  completed             :boolean          default("false")
#  pinned                :boolean          default("false")
#  completion_check      :boolean          default("false")
#  completion_check_time :datetime
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
    board = create(:board)
    3.times { board.tasks << create(:task) }
    board.tasks.last.pin!

    assert board.tasks.first.pinned?, "Pinned Task should show up first"
  end

  test "tasks with completion checks are not valid unless they have completion times" do
    task = build(:task, completion_check: true, completion_check_time: nil)
    assert_not task.valid?

    task.completion_check_time = DateTime.now + 5.days
    assert task.valid?
  end

  test "fetches tasks with outstanding completion checks" do
    no_check = [1,2,3,4].sample
    with_upcoming_check = [1,2,3,4].sample
    with_past_check = [1,2,3,4].sample

    no_check.times { create(:task) }
    with_upcoming_check.times { create(:task,
                                  completion_check: true,
                                  completion_check_time: DateTime.now + [1,2,3].sample.days) }
    with_past_check.times { create(:task,
                              completion_check: true,
                              completion_check_time: DateTime.now - [1,2,3].sample.days) }

    assert_equal with_past_check, Task.with_outstanding_completion_checks.count
  end
end
