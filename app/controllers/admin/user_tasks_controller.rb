class Admin::UserTasksController < ApplicationController
  load_and_authorize_resource
  
  def update
    if @user_task.update_attributes user_task_params
      flash[:success] = flash_message "updated"
    else
      flash[:failed] = flash_message "not_updated"
    end
    redirect_to :back
  end

  private
  def user_task_params
    params.require(:user_task).permit UserTask::ATTRIBUTES_PARAMS
  end 
end
