class User::CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @comments = current_user.comments
    @comments = @comments.page(params[:page]).per(5)
  end
end