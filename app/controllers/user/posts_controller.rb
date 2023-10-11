class User::PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.includes(:categories, :user).all.page(params[:page]).per(5)
  end

end