class User::PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.includes(:disasters, :user).all.ordered_by_comments_count
  end

end