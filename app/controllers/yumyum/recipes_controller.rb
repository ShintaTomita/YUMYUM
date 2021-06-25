class Yumyum::RecipesController < ApplicationController
  before_action :authenticate_chef!,    only: [:edit, :update, :destroy]
  before_action :create_only_chef,      only: [:new, :create, :update, :destroy]
  before_action :ensure_correct_recipe, only: [:edit, :update, :destroy]
  before_action :exist_recipe?,         only: [:show, :edit, :update, :destroy]

  def index
    @recipes = Recipe.all
  end

  def detail
    if user_signed_in? or chef_signed_in?
      @recipe = Recipe.find(params[:id])
      @chef = @recipe.chef
      if user_signed_in?
        @order = Order.where(user_id: current_user.id, recipe_id: @recipe.id).first
      end
    else
      flash[:alert] = "新規登録、ログインをしてください"
      render new_yumyum_user_path
    end

  end

  def show
    @recipe = Recipe.find(params[:id])
    if user_signed_in?
      order = Order.where(user_id: current_user.id, recipe_id: @recipe.id).first
      if order.present?
        if @recipe.id == order.recipe_id
          return true
        end
      else
        flash[:notice] = "レシピを購入してください"
        redirect_to "/yumyum//recipes/detail/#{@recipe.id}"
      end
    end

    if chef_signed_in?
      current_chef.id == @recipe.chef_id
      return true
    end
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(params_recipe)
    if @recipe.save
      flash[:notice] = "レシピを登録しました"
      redirect_to "/yumyum/recipes/detail/#{@recipe.id}"
    else
      render new_yumyum_recipe_path
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update!(params_recipe)
      flash[:notice] = "レシピを更新しました"
      redirect_to "/yumyum/recipes/#{@recipe.id}"
    else
      flash[:alert] = "レシピ内容を記載してください"
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      flash[:notice] = "レシピを削除しました"
      redirect_to new_yumyum_recipe_path
    end
  end

  def ensure_correct_recipe
    @recipe = Recipe.find(params[:id])
    if @recipe.chef_id != current_chef.id
      flash[:notice] = "権限がありません"
    redirect_to yumyum_recipes_path
    end
  end

  def create_only_chef
    if chef_signed_in?
      return false
    else
      user_signed_in?
      flash[:notice] = "このページはシェフ専用のページです"
      redirect_to yumyum_root_path
    end
  end

  def search
    @recipes = Recipe.search(params[:search])
    @title = params[:search]
  end

  def genre
    @recipes = Recipe.search(params[:genre])
    @titel = genre
    binding.pry
  end

  private
  def params_recipe
    params.require(:recipe).permit(:name, :food_stuff, :main_image, :first_process, :second_process, :third_process, :fourth_process,
                                   :first_image, :second_image, :third_image, :fourth_image, :advise, :chef_id)
  end
end
