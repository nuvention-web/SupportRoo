require 'test_helper'

class UserSignInTest < ActionDispatch::IntegrationTest
  test "users can sign in" do
    user = create(:user)
    sign_in_with_form(user)

    assert_equal user_path(user), current_path
    assert page.has_content?('Boards you support')
  end

  test "users can sign up" do
    assert_difference -> { User.count }, +1 do
      visit('/users/sign_up')
      fill_in('First name', with: "Bob")
      fill_in('Last name', with: "Smith")
      fill_in('Email', with: "bobsmith@example.com")
      fill_in('* Password', with: "foobar123", exact: true)
      fill_in('Password confirmation', with: "foobar123")
      click_button("Sign up")
    end

    assert_match 'users/', current_path
    assert page.has_content?('Welcome')
  end

  test "users can sign out" do
    user = create(:user)
    sign_in_with_form(user)
    click_link("Sign out")

    assert_equal root_path, current_path
  end
end
