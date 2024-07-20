class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'ユーザー情報が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'ユーザーが削除されました。'
  end

  def search
    @users = User.where('username LIKE ?', "%#{params[:q]}%")
    render :index
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end

  def authorize_user!
    unless current_user == @user || current_user.admin?
      redirect_to users_path, alert: 'アクセス権限がありません。'
    end
  end
end
