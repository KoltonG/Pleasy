require 'test_helper'

class CourseDetailsControllerTest < ActionController::TestCase
  setup do
    @course_detail = course_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:course_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course_detail" do
    assert_difference('CourseDetail.count') do
      post :create, course_detail: { coreq: @course_detail.coreq, credits: @course_detail.credits, dept: @course_detail.dept, description: @course_detail.description, name: @course_detail.name, number: @course_detail.number, prereq: @course_detail.prereq, writing: @course_detail.writing, year: @course_detail.year }
    end

    assert_redirected_to course_detail_path(assigns(:course_detail))
  end

  test "should show course_detail" do
    get :show, id: @course_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @course_detail
    assert_response :success
  end

  test "should update course_detail" do
    patch :update, id: @course_detail, course_detail: { coreq: @course_detail.coreq, credits: @course_detail.credits, dept: @course_detail.dept, description: @course_detail.description, name: @course_detail.name, number: @course_detail.number, prereq: @course_detail.prereq, writing: @course_detail.writing, year: @course_detail.year }
    assert_redirected_to course_detail_path(assigns(:course_detail))
  end

  test "should destroy course_detail" do
    assert_difference('CourseDetail.count', -1) do
      delete :destroy, id: @course_detail
    end

    assert_redirected_to course_details_path
  end
end
