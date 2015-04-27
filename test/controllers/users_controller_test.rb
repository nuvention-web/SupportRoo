require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = create(:user)
    @owner = create(:user_owning_board)
  end

  test "should show user when signed in" do
    sign_in @user
    get :show, id: @user.id.to_s
    assert_response :success
  end

  test "should redirect when user not signed in" do
    get :show, id: @user.id.to_s
    assert_response 302
    assert_redirected_to new_user_session_path
  end

  test "should redirect when user accesses another's page" do
    sign_in @user
    get :show, id: (@user.id + 1).to_s

    assert_redirected_to root_path
    assert_not_nil flash[:notice]
  end

  test "should assign owned board" do
    sign_in @owner
    get :show, id: @owner.id
    assert_not_nil assigns(:own_boards)
    assert_equal 1, assigns(:own_boards).count
  end

  test "should assign supporting board" do
    sign_in @user
    get :show, id: @user.id
    assert_not_nil assigns(:support_boards)
    assert_equal 1, assigns(:support_boards).count
  end
end
