require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @owner = create(:user)
    @supporter = create(:user)
    @board = create(:board)
    @task = create(:task)

    @owner.add_board(@board, true)
    @supporter.add_board(@board)
    sign_in @supporter
  end

  test "can create task with date and time" do
    assert_difference -> { Task.all.count } do
      post :create, { task: {
        task_type_id: 1,
        title: "title",
        description: "description",
        start_date: "09/06/2015",
        start_time: "7:12pm",
        board_id: @board.id }
      }
      @task = Task.last
      assert_equal 9, @task.start_time.month
      assert_equal 6, @task.start_time.day
      assert_equal 2015, @task.start_time.year
      assert_equal 19, @task.start_time.hour
    end
  end

  test "supporters can accept tasks" do
    assert_not @task.accepted?
    post :accept, { id: @task.id.to_s,
                    task: { supporter_message: "message" }
    }
    assert @task.reload.accepted?, "task should be accepted"
    assert_equal "message", @task.supporter_message
    assert_not_empty flash[:notice]
  end

  test "supporters can complete tasks" do
    assert_not @task.completed?
    @supporter.accept_task(@task, "message")
    assert_difference -> { ActionMailer::Base.deliveries.count }, +1 do
      post :complete, { id: @task.id.to_s }
      assert @task.reload.completed?
      assert_not_empty flash[:notice]
    end
  end

  test "board owners can pin tasks to the top of their boards" do
    assert_not @task.pinned?
    post :pin, { id: @task.id.to_s }
    assert @task.reload.pinned?, "task should be pinned"
    assert_redirected_to board_path(@task.board), "redirected"
  end

  test "clicking pin on a pinned task will unpin it" do
    @task.pin!
    post :pin, { id: @task.id.to_s }
    assert_not @task.reload.pinned?, "Task should have been unpinned"
    assert_redirected_to board_path(@task.board), "redirected"
  end
end
