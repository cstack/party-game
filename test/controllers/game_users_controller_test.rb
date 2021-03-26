require "test_helper"

class GameUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game_user = game_users(:one)
  end

  test "should get index" do
    get game_users_url
    assert_response :success
  end

  test "should get new" do
    get new_game_user_url
    assert_response :success
  end

  test "should create game_user" do
    assert_difference('GameUser.count') do
      post game_users_url, params: { game_user: { game_id: @game_user.game_id, user_id: @game_user.user_id } }
    end

    assert_redirected_to game_user_url(GameUser.last)
  end

  test "should show game_user" do
    get game_user_url(@game_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_game_user_url(@game_user)
    assert_response :success
  end

  test "should update game_user" do
    patch game_user_url(@game_user), params: { game_user: { game_id: @game_user.game_id, user_id: @game_user.user_id } }
    assert_redirected_to game_user_url(@game_user)
  end

  test "should destroy game_user" do
    assert_difference('GameUser.count', -1) do
      delete game_user_url(@game_user)
    end

    assert_redirected_to game_users_url
  end
end
