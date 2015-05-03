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
