require "application_system_test_case"

class AssignmentsTest < ApplicationSystemTestCase
  setup do
    @assignment = assignments(:one)
  end

  test "visiting the index" do
    visit assignments_url
    assert_selector "h1", text: "Movie Assignments"
  end

  test "creating a Movie assignment" do
    visit assignments_url
    click_on "New Movie Assignment"

    fill_in "Game", with: @assignment.game_id
    fill_in "Movie", with: @assignment.movie_id
    fill_in "User", with: @assignment.user_id
    click_on "Create Movie assignment"

    assert_text "Movie assignment was successfully created"
    click_on "Back"
  end

  test "updating a Movie assignment" do
    visit assignments_url
    click_on "Edit", match: :first

    fill_in "Game", with: @assignment.game_id
    fill_in "Movie", with: @assignment.movie_id
    fill_in "User", with: @assignment.user_id
    click_on "Update Movie assignment"

    assert_text "Movie assignment was successfully updated"
    click_on "Back"
  end

  test "destroying a Movie assignment" do
    visit assignments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Movie assignment was successfully destroyed"
  end
end
