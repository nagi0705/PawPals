class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    @users = User.all
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'ユーザー情報が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      @user.group_memberships.destroy_all
      @user.pets.destroy_all
      @user.posts.destroy_all
      @user.destroy
    end
    redirect_to admin_users_path, notice: 'ユーザーが削除されました。'
  rescue ActiveRecord::RecordNotDestroyed => e
    redirect_to admin_users_path, alert: 'ユーザーの削除に失敗しました。'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end

  def authorize_admin!
    redirect_to root_path, alert: 'アクセス権限がありません。' unless current_user.admin?
  end
end
