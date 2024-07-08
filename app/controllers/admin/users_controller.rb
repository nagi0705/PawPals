module Admin
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :admin_user
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
        redirect_to admin_users_path, notice: 'ユーザー情報を更新しました。'
      else
        render :edit
      end
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to admin_users_path, notice: 'ユーザーを削除しました。'
    end

    private

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def user_params
      params.require(:user).permit(:email, :admin)
    end
  end
end
