class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post

  def create
    unless @post.likes.where(user: current_user).exists?
      @post.likes.create(user: current_user)
      flash[:notice] = "投稿にいいねしました。"
    else
      flash[:notice] = "すでにいいねしています。"
    end
    redirect_to post_path(@post)
  end

  def destroy
    like = @post.likes.find(params[:id])
    like.destroy
    flash[:notice] = "いいねを解除しました。"
    redirect_to post_path(@post)
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end
end
