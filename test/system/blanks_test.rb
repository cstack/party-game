require "application_system_test_case"

class BlanksTest < ApplicationSystemTestCase
  setup do
    @blank = blanks(:one)
  end

  test "visiting the index" do
    visit blanks_url
    assert_selector "h1", text: "Blanks"
  end

  test "creating a Blank" do
    visit blanks_url
    click_on "New Blank"

    fill_in "Key", with: @blank.key
    fill_in "Movie", with: @blank.movie_id
    fill_in "Value", with: @blank.value
    click_on "Create Blank"

    assert_text "Blank was successfully created"
    click_on "Back"
  end

  test "updating a Blank" do
    visit blanks_url
    click_on "Edit", match: :first

    fill_in "Key", with: @blank.key
    fill_in "Movie", with: @blank.movie_id
    fill_in "Value", with: @blank.value
    click_on "Update Blank"

    assert_text "Blank was successfully updated"
    click_on "Back"
  end

  test "destroying a Blank" do
    visit blanks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Blank was successfully destroyed"
  end
end
