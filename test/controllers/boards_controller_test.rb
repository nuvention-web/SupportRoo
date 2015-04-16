require 'test_helper'

class BoardsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = create(:user)
    @owner = create(:user_owning_board)
  end

  test "should get show for owner" do
    sign_in @owner
    get :show, id: @owner.owned_boards.first.id.to_s
    assert_response :success
  end

  test "should redirect if not owner" do
    sign_in @user
    get :show, id: @user.boards.first.id.to_s
    assert_redirected_to root_path
    assert_not_nil flash[:warning]
  end
end
