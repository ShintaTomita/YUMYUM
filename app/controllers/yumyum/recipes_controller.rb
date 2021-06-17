class Yumyum::RecipesController < ApplicationController

  def index
    @repice = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(params_recipe)
    if @recipe.save
      flash[:notice] = "レシピを登録しました"
      redirect_to yumyum_root_path
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
  end

  private
  def params_recipe
    params.require(:recipe).permit(:name, :seasoning, :main_image, :process, :images, :advise)
  end
end
