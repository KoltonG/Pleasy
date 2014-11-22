class CourseDetailsController < ApplicationController
  before_action :set_course_detail, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @course_details = CourseDetail.all
    respond_with(@course_details)
  end

  def show
    respond_with(@course_detail)
  end

  def new
    @course_detail = CourseDetail.new
    respond_with(@course_detail)
  end

  def edit
  end

  def create
    @course_detail = CourseDetail.new(course_detail_params)
    @course_detail.save
    respond_with(@course_detail)
  end

  def update
    @course_detail.update(course_detail_params)
    respond_with(@course_detail)
  end

  def destroy
    @course_detail.destroy
    respond_with(@course_detail)
  end

  private
    def set_course_detail
      @course_detail = CourseDetail.find(params[:id])
    end

    def course_detail_params
      params.require(:course_detail).permit(:dept, :number, :year, :name, :credits, :writing, :prereq, :coreq, :description)
    end
end
