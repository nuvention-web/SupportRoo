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
  end

  test "supporters can complete tasks" do
    assert_not @task.completed?
    post :complete, { id: @task.id.to_s }
    assert @task.reload.completed?
  end
end
