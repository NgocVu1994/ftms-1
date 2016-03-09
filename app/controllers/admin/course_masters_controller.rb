class Admin::CourseMastersController < ApplicationController
  before_action :load_course_master, except: [:index, :new, :create]

  def index
    @course_masters = Course.masters
  end

  def new
    @course_master = Course.new
  end

  def create
    @course_master = Course.new course_master_params
    if @course_master.save
      flash[:success] = flash_message "created"
      redirect_to admin_course_masters_path
    else
      flash[:failed] = flash_message "not created"
      render :new
    end
  end

  def update
    if @course_master.update_attributes course_master_params
      flash[:success] = flash_message "updated"
      redirect_to admin_course_masters_path
    else
      flash[:failed] = flash_message "not updated"
      render :edit
    end
  end

  def destroy
    if @course_master.destroy
      flash[:success] = flash_message "deleted"
    else
      flash[:failed] = flash_message "not deleted"
    end
    redirect_to :back
  end

  private
  def course_master_params
    params.require(:course).permit :name, :description
  end

  def load_course_master
    @course_master = Course.find params[:id]
  end
end
