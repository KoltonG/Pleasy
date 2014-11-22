require 'test_helper'

class PrerequisitesControllerTest < ActionController::TestCase
  setup do
    @prerequisite = prerequisites(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:prerequisites)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create prerequisite" do
    assert_difference('Prerequisite.count') do
      post :create, prerequisite: { course_id: @prerequisite.course_id, prereq_id: @prerequisite.prereq_id }
    end

    assert_redirected_to prerequisite_path(assigns(:prerequisite))
  end

  test "should show prerequisite" do
    get :show, id: @prerequisite
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @prerequisite
    assert_response :success
  end

  test "should update prerequisite" do
    patch :update, id: @prerequisite, prerequisite: { course_id: @prerequisite.course_id, prereq_id: @prerequisite.prereq_id }
    assert_redirected_to prerequisite_path(assigns(:prerequisite))
  end

  test "should destroy prerequisite" do
    assert_difference('Prerequisite.count', -1) do
      delete :destroy, id: @prerequisite
    end

    assert_redirected_to prerequisites_path
  end
end
