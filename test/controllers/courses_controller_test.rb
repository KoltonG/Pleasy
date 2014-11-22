require 'test_helper'

class CoursesControllerTest < ActionController::TestCase
  setup do
    @course = courses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:courses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course" do
    assert_difference('Course.count') do
      post :create, course: { city: @course.city, credits: @course.credits, day_fri: @course.day_fri, day_mon: @course.day_mon, day_sat: @course.day_sat, day_sun: @course.day_sun, day_sun: @course.day_sun, day_thu: @course.day_thu, day_tue: @course.day_tue, day_wed: @course.day_wed, dept: @course.dept, lab: @course.lab, lab_day_fri: @course.lab_day_fri, lab_day_mon: @course.lab_day_mon, lab_day_sat: @course.lab_day_sat, lab_day_sun: @course.lab_day_sun, lab_day_sun: @course.lab_day_sun, lab_day_thu: @course.lab_day_thu, lab_day_tue: @course.lab_day_tue, lab_day_wed: @course.lab_day_wed, lab_location: @course.lab_location, lab_style: @course.lab_style, lab_time_end: @course.lab_time_end, lab_time_start: @course.lab_time_start, location: @course.location, name: @course.name, number: @course.number, prof_name: @course.prof_name, room: @course.room, section: @course.section, section_number: @course.section_number, style: @course.style, term: @course.term, time_end: @course.time_end, time_start: @course.time_start, year: @course.year }
    end

    assert_redirected_to course_path(assigns(:course))
  end

  test "should show course" do
    get :show, id: @course
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @course
    assert_response :success
  end

  test "should update course" do
    patch :update, id: @course, course: { city: @course.city, credits: @course.credits, day_fri: @course.day_fri, day_mon: @course.day_mon, day_sat: @course.day_sat, day_sun: @course.day_sun, day_sun: @course.day_sun, day_thu: @course.day_thu, day_tue: @course.day_tue, day_wed: @course.day_wed, dept: @course.dept, lab: @course.lab, lab_day_fri: @course.lab_day_fri, lab_day_mon: @course.lab_day_mon, lab_day_sat: @course.lab_day_sat, lab_day_sun: @course.lab_day_sun, lab_day_sun: @course.lab_day_sun, lab_day_thu: @course.lab_day_thu, lab_day_tue: @course.lab_day_tue, lab_day_wed: @course.lab_day_wed, lab_location: @course.lab_location, lab_style: @course.lab_style, lab_time_end: @course.lab_time_end, lab_time_start: @course.lab_time_start, location: @course.location, name: @course.name, number: @course.number, prof_name: @course.prof_name, room: @course.room, section: @course.section, section_number: @course.section_number, style: @course.style, term: @course.term, time_end: @course.time_end, time_start: @course.time_start, year: @course.year }
    assert_redirected_to course_path(assigns(:course))
  end

  test "should destroy course" do
    assert_difference('Course.count', -1) do
      delete :destroy, id: @course
    end

    assert_redirected_to courses_path
  end
end
