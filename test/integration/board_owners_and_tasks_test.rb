require 'test_helper'

class BoardOwnersAndTasksTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
    @board = create(:board, name: "board name", description: "board description")
    @board.add_owner(@user)
    sign_in_with_form(@user)
  end

  test "owners see their owned boards" do
    visit(user_path(@user))
    assert page.has_content?(@board.name)
    assert page.has_content?(@board.description)
    assert page.has_content?("Create a new board")
  end

  test "users can add new boards and own them" do
    visit(user_path(@user))
    assert_difference -> { @user.owned_boards.count }, +1 do
      click_link("Create a new board")
      fill_in("Name", with: "second")
      fill_in("Description", with: "second")
      click_button("Create board")
    end

    assert page.has_content?("Board created successfully")
    assert page.has_content?("second")
  end

  test "owners can add a task" do
    visit(board_path(@board))

    assert page.has_content?("Add a new task:")
    assert page.has_content?("Your tasks")

    within("#deliveryModal") do
      fill_in 'Title', with: "title"
      fill_in 'Description', with: "description"
      click_button "Add task"
    end

    assert page.has_selector?(".task-info")
  end
end
