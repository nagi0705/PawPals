module Admin
  class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :admin_user

    def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy
      redirect_to request.referrer || root_path, notice: 'コメントを削除しました。'
    end

    private

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
  end
end
