class CoursesUsersController < ApplicationController
  before_action :set_courses_user, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @courses_users = CoursesUser.all
    respond_with(@courses_user)
  end

  def show
    respond_with(@courses_user)
  end

  def new
    @courses_user = CoursesUser.new
    respond_with(@courses_user)
  end

  def edit
  end

  def create
    @courses_user = CoursesUser.new(courses_user_params)
    @courses_user.save
    respond_with(@courses_user)
  end

  def update
    @courses_user.update(courses_user_params)
    respond_with(@courses_user)
  end

  def register_course
    @newregistration = CoursesUser.new(course_id: params[:course_id], user_id: current_user.id, year: params[:year], status: params[:status])
    if @newregistration.save
      flash.now[:error] = "Ok"
    else
      flash.now[:error] = "Could not save client"
     # render action: "new"
    end

    #params[:course_id]
    #params[:year]
    #params[:term]
    #current_user.id

    #@courses_user.update(courses_user_params)
    #respond_with(@courses_user)
  end

  def destroy
    @courses_user.destroy
    respond_with(@courses_user)
  end

  private
  def set_courses_user
    @courses_user = CoursesUser.find(params[:id])
  end

  def courses_user_params
    params.require(:courses_user).permit(:course_id, :user_id, :year, :term, :status)
  end

end
