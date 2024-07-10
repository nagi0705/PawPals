class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users = User.search(params[:search])
  end

  def show
  end

  def search
    @users = User.search(params[:search])
    render :index
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    unless @user
      flash[:alert] = "ユーザーが見つかりません"
      redirect_to root_path
    end
  end
end
