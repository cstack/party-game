require "test_helper"

class MovieAssignmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @movie_assignment = movie_assignments(:one)
  end

  test "should get index" do
    get movie_assignments_url
    assert_response :success
  end

  test "should get new" do
    get new_movie_assignment_url
    assert_response :success
  end

  test "should create movie_assignment" do
    assert_difference('MovieAssignment.count') do
      post movie_assignments_url, params: { movie_assignment: { game_id: @movie_assignment.game_id, movie_id: @movie_assignment.movie_id, user_id: @movie_assignment.user_id } }
    end

    assert_redirected_to movie_assignment_url(MovieAssignment.last)
  end

  test "should show movie_assignment" do
    get movie_assignment_url(@movie_assignment)
    assert_response :success
  end

  test "should get edit" do
    get edit_movie_assignment_url(@movie_assignment)
    assert_response :success
  end

  test "should update movie_assignment" do
    patch movie_assignment_url(@movie_assignment), params: { movie_assignment: { game_id: @movie_assignment.game_id, movie_id: @movie_assignment.movie_id, user_id: @movie_assignment.user_id } }
    assert_redirected_to movie_assignment_url(@movie_assignment)
  end

  test "should destroy movie_assignment" do
    assert_difference('MovieAssignment.count', -1) do
      delete movie_assignment_url(@movie_assignment)
    end

    assert_redirected_to movie_assignments_url
  end
end
