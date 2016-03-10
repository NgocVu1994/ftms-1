class Admin::AssignTraineesController < ApplicationController
  load_and_authorize_resource :course

  def edit
    @users = User.all
    @users.each do |user|
      @course.user_courses.new user: user unless @course.user_ids.include? user.id
    end
  end

  def update
    if @course.update_attributes course_params
      flash[:success] = flash_message "updated"
    else
      flash[:danger] = flash_message "not updated"
    end
    redirect_to redirect_to admin_course_path @course
  end

  private
  def course_params
    params.require(:course).permit user_courses_attributes: [:id, :user_id, :_destroy]
  end
end
