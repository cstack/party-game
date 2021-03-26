require "application_system_test_case"

class GameUsersTest < ApplicationSystemTestCase
  setup do
    @game_user = game_users(:one)
  end

  test "visiting the index" do
    visit game_users_url
    assert_selector "h1", text: "Game Users"
  end

  test "creating a Game user" do
    visit game_users_url
    click_on "New Game User"

    fill_in "Game", with: @game_user.game_id
    fill_in "User", with: @game_user.user_id
    click_on "Create Game user"

    assert_text "Game user was successfully created"
    click_on "Back"
  end

  test "updating a Game user" do
    visit game_users_url
    click_on "Edit", match: :first

    fill_in "Game", with: @game_user.game_id
    fill_in "User", with: @game_user.user_id
    click_on "Update Game user"

    assert_text "Game user was successfully updated"
    click_on "Back"
  end

  test "destroying a Game user" do
    visit game_users_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Game user was successfully destroyed"
  end
end
