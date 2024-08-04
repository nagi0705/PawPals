class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @posts = if params[:query].present?
               Post.where('title LIKE ? OR content LIKE ?', "%#{params[:query]}%", "%#{params[:query]}%")
             else
               Post.all
             end
  end

  def search
    @posts = Post.where('title LIKE ? OR content LIKE ?', "%#{params[:query]}%", "%#{params[:query]}%")
    render :index
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user)
    @likes = @post.likes.includes(:user)  # 追加: いいねしたユーザーの情報を取得
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: '投稿が作成されました。' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: '投稿が更新されました。' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if current_user.admin? || @post.user == current_user
      @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_url, notice: '投稿が削除されました。' }
        format.json { head :no_content }
      end
    else
      redirect_to posts_path, alert: 'アクセス権限がありません。'
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :image)
  end

  def authorize_user!
    unless current_user == @post.user || current_user.admin?
      redirect_to posts_path, alert: 'アクセス権限がありません。'
    end
  end
end
