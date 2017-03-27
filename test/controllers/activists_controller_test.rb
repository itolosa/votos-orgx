require 'test_helper'

class ActivistsControllerTest < ActionController::TestCase
  setup do
    @activist = activists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:activists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create activist" do
    assert_difference('Activist.count') do
      post :create, activist: {  }
    end

    assert_redirected_to activist_path(assigns(:activist))
  end

  test "should show activist" do
    get :show, id: @activist
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @activist
    assert_response :success
  end

  test "should update activist" do
    patch :update, id: @activist, activist: {  }
    assert_redirected_to activist_path(assigns(:activist))
  end

  test "should destroy activist" do
    assert_difference('Activist.count', -1) do
      delete :destroy, id: @activist
    end

    assert_redirected_to activists_path
  end
end
