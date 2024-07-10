# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group

  def create
    @message = @group.messages.build(message_params)
    @message.user = current_user
    if @message.save
      redirect_to @group, notice: 'メッセージが送信されました。'
    else
      redirect_to @group, alert: 'メッセージの送信に失敗しました。'
    end
  end

  def destroy
    @message = @group.messages.find(params[:id])
    if @message.user == current_user || current_user.admin?
      @message.destroy
      redirect_to @group, notice: 'メッセージが削除されました。'
    else
      redirect_to @group, alert: 'メッセージの削除に失敗しました。'
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
