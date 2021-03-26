require "test_helper"

class BlanksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blank = blanks(:one)
  end

  test "should get index" do
    get blanks_url
    assert_response :success
  end

  test "should get new" do
    get new_blank_url
    assert_response :success
  end

  test "should create blank" do
    assert_difference('Blank.count') do
      post blanks_url, params: { blank: { key: @blank.key, movie_id: @blank.movie_id, value: @blank.value } }
    end

    assert_redirected_to blank_url(Blank.last)
  end

  test "should show blank" do
    get blank_url(@blank)
    assert_response :success
  end

  test "should get edit" do
    get edit_blank_url(@blank)
    assert_response :success
  end

  test "should update blank" do
    patch blank_url(@blank), params: { blank: { key: @blank.key, movie_id: @blank.movie_id, value: @blank.value } }
    assert_redirected_to blank_url(@blank)
  end

  test "should destroy blank" do
    assert_difference('Blank.count', -1) do
      delete blank_url(@blank)
    end

    assert_redirected_to blanks_url
  end
end
