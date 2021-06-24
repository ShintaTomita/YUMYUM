class Yumyum::RecipesController < ApplicationController
  before_action :authenticate_chef!,    only: [:edit, :update, :destroy]
  before_action :ensure_correct_recipe, only: [:edit, :update, :destroy]
  before_action :exist_recipe?,         only: [:show, :edit, :update, :destroy]

  def index
    @recipes = Recipe.all
  end

  def detail
    @recipe = Recipe.find(params[:id])
    @chef = @recipe.chef
  end

  def show
    @recipe = Recipe.find(params[:id])
    @chef = @recipe.chef
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(params_recipe)
    if @recipe.save
      flash[:notice] = "レシピを登録しました"
      redirect_to "/yumyum/recipes/#{@recipe.id}"
    else
      render new_yumyum_recipe_path
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(params_recipe)
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

  def search
    @recipes = Recipe.search(params[:name], params[:food_stuff], params[:search])
  end

  private
  def params_recipe
    params.require(:recipe).permit(:name, :food_stuff, :main_image, :first_process, :second_process, :third_process, :fourth_process,
                                   :first_image, :second_image, :third_image, :fourth_image, :advise, :chef_id, :genre, :prouct_id, :price)
  end
end
