require 'test_helper'

class FicsControllerTest < ActionController::TestCase
  setup do
    @fic = fics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fic" do
    assert_difference('Fic.count') do
      post :create, fic: { title: @fic.title }
    end

    assert_redirected_to fic_path(assigns(:fic))
  end

  test "should show fic" do
    get :show, id: @fic
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fic
    assert_response :success
  end

  test "should update fic" do
    put :update, id: @fic, fic: { title: @fic.title }
    assert_redirected_to fic_path(assigns(:fic))
  end

  test "should destroy fic" do
    assert_difference('Fic.count', -1) do
      delete :destroy, id: @fic
    end

    assert_redirected_to fics_path
  end
end
