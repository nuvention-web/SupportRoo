require 'test_helper'

class SignupsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "gets to index" do
    get :index
    assert_response :success
  end

  test "gets to new" do
    get :new
    assert_response :success
  end

  test "posts to create" do
    post :create, { signup: { email: "foo@bar.com" } }
    assert_response 302 # redirect
  end
end

