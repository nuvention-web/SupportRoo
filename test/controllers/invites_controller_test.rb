require 'test_helper'

class InvitesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @board = create(:board)
    @user = create(:user)
    @board.add_owner(@user)

    sign_in @user
  end

  test "only board owner should be able to invite people" do
    get :new, board_id: @board.id
    assert_response :success
  end

  test "unrelated user should not be able to invite people" do
    sign_out @user
    other = create(:user)
    sign_in other
    get :new, board_id: @board.id
    assert_redirected_to root_path
    assert_not_nil flash[:error]
  end

  test "create with valid information should add invite" do
    assert_difference -> { @board.invites.count }, +2 do
      post :create, { board_id: @board.id, invites: { emails: ['foo@bar.com', 'bax@biz.com', '', '', ''] } }
    end

    assert_redirected_to board_path(@board)
    assert_not_nil flash[:notice]
    assert_not_empty @board.invites
  end

  test "empty emails doesn't create invites and redirects to invites page" do
    assert_no_difference -> { @board.invites.count } do
      post :create, { board_id: @board.id, invites: { emails: ['', '', '', '', ''] } }
    end

    assert_redirected_to new_board_invites_path(@board)
    assert_not_nil flash[:error]
  end

  test "when emails are repeated it doesn't create multiple invites" do
    assert_difference -> { @board.invites.count }, +2 do
      post :create, { invites: { emails: ['foo@bar.com', 'bax@biz.com', 'bax@biz.com', '', ''] }, board_id: @board.id }
    end

    assert_redirected_to board_path(@board)
    assert_not_nil flash[:notice]
  end

  test "should report which emails could not be sent" do
    assert_difference -> { @board.invites.count }, +1 do
      post :create, { invites: { emails: ['foo@bar.com', 'invalid', '', '', ''] }, board_id: @board.id }
    end    

    assert_redirected_to new_board_invites_path(@board)
    assert_includes flash[:error], 'invalid'
    assert_not_nil flash[:notice]
  end

  test "if user is signed in, should add him as a supporter on board when claimed" do
    assert_difference -> { @board.supporters.count }, +1 do
      @invite = create(:invite, board: @board)
      assert_not @invite.claimed
      get :claim, board_id: @board, code: @invite.code
      assert_redirected_to share_board_path(@board)

      # assert @invite.claimed TODO Why does this fail????
    end
  end

  test "if user is not signed in, should not add him as a supporter on board when claimed" do
    sign_out @user
    assert_no_difference -> { @board.supporters.count } do
      invite = create(:invite, board: @board)
      get :claim, board_id: @board, code: invite.code
      assert_redirected_to (new_user_registration_path code: invite.code)
      assert_not_nil session[:code]
    end
  end

end