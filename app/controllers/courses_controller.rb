class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @courses = Course.all
    respond_with(@courses)
  end

  def show
    respond_with(@course)
  end

  def new
    @course = Course.new
    respond_with(@course)
  end

  def edit
  end

  def create
    @course = Course.new(course_params)
    @course.save
    respond_with(@course)
  end

  def update
    @course.update(course_params)
    respond_with(@course)
  end

  def destroy
    @course.destroy
    respond_with(@course)
  end

  private
    def set_course
      @course = Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:term, :year, :dept, :number, :section, :section_number, :name, :city, :style, :day_sun, :day_mon, :day_tue, :day_wed, :day_thu, :day_fri, :day_sat, :day_sun, :time_start, :time_end, :room, :location, :lab, :lab_style, :lab_location, :lab_day_sun, :lab_day_mon, :lab_day_tue, :lab_day_wed, :lab_day_thu, :lab_day_fri, :lab_day_sat, :lab_day_sun, :lab_time_start, :lab_time_end, :prof_name, :credits)
    end
end
