require 'test_helper'

class ActivistFrontsControllerTest < ActionController::TestCase
  setup do
    @activist_front = activist_fronts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:activist_fronts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create activist_front" do
    assert_difference('ActivistFront.count') do
      post :create, activist_front: {  }
    end

    assert_redirected_to activist_front_path(assigns(:activist_front))
  end

  test "should show activist_front" do
    get :show, id: @activist_front
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @activist_front
    assert_response :success
  end

  test "should update activist_front" do
    patch :update, id: @activist_front, activist_front: {  }
    assert_redirected_to activist_front_path(assigns(:activist_front))
  end

  test "should destroy activist_front" do
    assert_difference('ActivistFront.count', -1) do
      delete :destroy, id: @activist_front
    end

    assert_redirected_to activist_fronts_path
  end
end
