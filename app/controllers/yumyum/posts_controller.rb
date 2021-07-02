class Yumyum::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def new
    @post = Post.new
    @recipe = Recipe.find_by(id: params[:recipe])

  end

  def create
    @post = Post.new(params_post)
    if @post.save!
      flash[:notice] = "コメントありがとうございます"
      redirect_to yumyum_root_path
    end

  end

  def show
  end

  private

  def params_post
    params.require(:post).permit(:content, :user_id, :recipe_id)
  end

end
