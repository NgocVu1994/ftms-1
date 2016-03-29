class Admin::UserTypesController < ApplicationController
  load_and_authorize_resource except: :show

  def index
    @user_type = UserType.new
  end

  def create
    if @user_type.save
      flash[:success] = flash_message "created"
      redirect_to admin_user_types_path
    else
      flash[:failed] = flash_message "not_created"
      redirect_to :new
    end
  end

  def update
    if @user_type.update_attributes user_type_params
      flash[:success] = flash_message "updated"
      redirect_to admin_user_types_path
    else
      flash[:failed] = flash_message "not_update"
      render :edit
    end
  end

  def destroy
    if @user_type.destroy
      flash[:success] = flash_message "deleted"
    else
      flash[:failed] = flash_message "not_deleted"
    end
    redirect_to :back
  end

  private
  def user_type_params
    params.require(:user_type).permit UserType::ATTRIBUTES_PARAMS
  end
end
