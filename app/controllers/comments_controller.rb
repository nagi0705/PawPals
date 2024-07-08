# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: [:destroy]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @post, notice: 'コメントが追加されました。'
    else
      redirect_to @post, alert: 'コメントの追加に失敗しました。'
    end
  end

  def destroy
    if @comment.user == current_user || current_user.admin?
      @comment.destroy
      redirect_to @post, notice: 'コメントが削除されました。'
    else
      redirect_to @post, alert: 'コメントの削除に失敗しました。'
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
