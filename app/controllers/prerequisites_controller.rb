class PrerequisitesController < ApplicationController
  before_action :set_prerequisite, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @prerequisites = Prerequisite.all
    respond_with(@prerequisites)
  end

  def show
    respond_with(@prerequisite)
  end

  def new
    @prerequisite = Prerequisite.new
    respond_with(@prerequisite)
  end

  def edit
  end

  def create
    @prerequisite = Prerequisite.new(prerequisite_params)
    @prerequisite.save
    respond_with(@prerequisite)
  end

  def update
    @prerequisite.update(prerequisite_params)
    respond_with(@prerequisite)
  end

  def destroy
    @prerequisite.destroy
    respond_with(@prerequisite)
  end

  private
    def set_prerequisite
      @prerequisite = Prerequisite.find(params[:id])
    end

    def prerequisite_params
      params.require(:prerequisite).permit(:course_detail_id, :prereq_id)
    end
end
