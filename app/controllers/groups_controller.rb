class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:show, :edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def show
    @message = Message.new
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.admin_id = current_user.id
    if @group.save
      @group.users << current_user unless @group.users.include?(current_user)
      redirect_to @group, notice: 'グループが作成されました。'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      @group.user_ids = params[:group][:user_ids].uniq
      @group.users << current_user unless @group.users.include?(current_user)
      redirect_to @group, notice: 'グループが更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_url, notice: 'グループが削除されました。'
  end

  def search
    @groups = Group.where('name LIKE ?', "%#{params[:query]}%")
    render :index
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description, user_ids: [])
  end

  def authorize_user!
    unless current_user.admin? || @group.users.include?(current_user)
      redirect_to groups_path, alert: 'アクセス権限がありません。'
    end
  end
end
