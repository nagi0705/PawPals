class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    ActiveRecord::Base.transaction do
      @user.group_memberships.destroy_all  # これで関連するgroup_membershipsを削除
      @user.destroy
    end
    redirect_to admin_users_path, notice: 'User was successfully destroyed.'
  rescue ActiveRecord::InvalidForeignKey
    redirect_to admin_users_path, alert: 'Failed to destroy user due to foreign key constraint.'
  end

  private

  def authenticate_admin!
    redirect_to root_path, alert: 'Not authorized.' unless current_user && current_user.admin?
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :admin)
  end
end
