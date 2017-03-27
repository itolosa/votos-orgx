require 'test_helper'

class VoteCandidatesControllerTest < ActionController::TestCase
  setup do
    @vote_candidate = vote_candidates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vote_candidates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vote_candidate" do
    assert_difference('VoteCandidate.count') do
      post :create, vote_candidate: { candidate_id: @vote_candidate.candidate_id, vote_id: @vote_candidate.vote_id }
    end

    assert_redirected_to vote_candidate_path(assigns(:vote_candidate))
  end

  test "should show vote_candidate" do
    get :show, id: @vote_candidate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vote_candidate
    assert_response :success
  end

  test "should update vote_candidate" do
    patch :update, id: @vote_candidate, vote_candidate: { candidate_id: @vote_candidate.candidate_id, vote_id: @vote_candidate.vote_id }
    assert_redirected_to vote_candidate_path(assigns(:vote_candidate))
  end

  test "should destroy vote_candidate" do
    assert_difference('VoteCandidate.count', -1) do
      delete :destroy, id: @vote_candidate
    end

    assert_redirected_to vote_candidates_path
  end
end
