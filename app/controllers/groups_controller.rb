# app/controllers/groups_controller.rb
class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authorize_group_access, only: [:show]

  def index
    @groups = Group.all
  end

  def show
    @messages = @group.messages.includes(:user)
    @message = @group.messages.build
  end

  def new
    @group = Group.new
  end

  def edit
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to @group, notice: 'グループが作成されました。'
    else
      render :new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to @group, notice: 'グループが更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_url, notice: 'グループが削除されました。'
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description, user_ids: [])
  end

  def authorize_group_access
    unless @group.users.include?(current_user)
      redirect_to groups_path, alert: 'このグループにアクセスする権限がありません。'
    end
  end
end
