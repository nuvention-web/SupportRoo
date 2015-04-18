require 'test_helper'

class BoardsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = create(:user)
    @owner = create(:user_owning_board)
    sign_in @owner
  end

  def teardown
    sign_out @owner
  end

  test "should get show for owner" do
    get :show, id: @owner.owned_boards.first.id.to_s
    assert_response :success
  end

  test "should redirect if not owner" do
    sign_in @user
    get :show, id: @user.boards.first.id.to_s
    assert_redirected_to root_path
    assert_not_nil flash[:warning]
  end

  test "delete should delete board" do
    assert_difference -> { @owner.boards.count }, -1 do
      delete :destroy, id: @owner.boards.first.id.to_s
    end
  end

  test "new page should render form" do
    get :new
    assert_response :success
  end

  test "create should make a new board and add user as owner" do
    sign_in @user
    assert_difference -> { @user.owned_boards.count }, +1 do
      post :create, { board: { name: "A cool board", description: "bar" } }
    end
  end

  test "create should not make a new board with invalid information" do
    sign_in @user
    assert_no_difference -> { @user.owned_boards.count} do
      post :create, { board: { name: "", description: "" } }
    end
    assert_redirected_to new_board_path
    assert_not_nil flash[:error]
  end

  test "share view should only be visible to supporters" do
    sign_in @user
    board = create(:board)
    get :share, id: board.id.to_s
    assert_redirected_to user_path(@user)
    assert_not_nil flash[:warning]
  end

  test "share should redirect to show for board owner" do
    board = @owner.owned_boards.first
    get :share, id: board.id.to_s
    assert_redirected_to board_path(board)
  end

  test "supporters should be able to view available tasks and their own tasks" do
    sign_in @user
    board = create(:board_with_tasks)
    board.add_supporter(@user)
    @user.accept_task(board.tasks.first)

    get :share, id: board.id.to_s
    assert_response :success

    assert_not_empty assigns(:unaccepted_tasks)
    assert_not_empty assigns(:user_tasks)
  end
end
