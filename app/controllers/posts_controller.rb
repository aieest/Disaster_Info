class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :validate_post_owner, only: [:edit, :update, :destroy]

  def index
    @posts = Post.includes(:categories, :user, :comments)
                 .joins("LEFT JOIN comments ON comments.post_id = posts.id")
                 .group("posts.id")
                 .select("posts.*, COUNT(comments.id) AS comments_count")
                 .order("comments_count DESC")

    @hot_posts = @posts.limit(3)
    @posts = @posts.page(params[:page]).per(3)
  end
  def new
    @post = Post.new

  end
  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] = 'Post created successfully'
      redirect_to posts_path
    else
      flash.now[:alert] = 'Post create failed'
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Post updated successfully'
      redirect_to posts_path
    else
      flash.now[:alert] = 'Post update failed'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = 'Post destroyed successfully'
    redirect_to posts_path
  end

  private
  def validate_post_owner
    unless @post.user == current_user
      flash[:notice] = 'the post not belongs to you'
      redirect_to posts_path
    end
  end
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :address, :image, category_ids: [])
  end
end

