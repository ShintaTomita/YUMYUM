# frozen_string_literal: true

module Yumyum
  class RecipesController < ApplicationController
    before_action :authenticate_chef!,    only: %i[edit update destroy]
    before_action :create_only_chef,      only: %i[new create update destroy]
    before_action :protect_show_page,     only: [:show]
    before_action :ensure_correct_recipe, only: %i[edit update destroy]
    before_action :exist_recipe?,         only: %i[show edit update destroy]

    def index
      @recipes = Recipe.includes([:chef], [:genre]).all.page(params[:page]).per(12)
    end

    def detail
      if user_signed_in? || chef_signed_in?
        @recipe = Recipe.includes([:chef]).find(params[:id])
        @relation_recipes = Recipe.includes([:chef],
                                            [:genre]).where(genre_id: @recipe.genre.id).where.not(id: @recipe.id).limit(4)
        @posts = @recipe.posts.includes([:user]).limit(6)
        @order = Order.where(user_id: current_user.id, recipe_id: @recipe.id).first if user_signed_in?
      else
        flash[:alert] = '新規登録、ログインをしてください'
        render new_yumyum_user_path
      end
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
        flash[:notice] = 'レシピを登録しました'
        redirect_to "/yumyum/recipes/detail/#{@recipe.id}"
      else
        flash[:alert] = "レシピ内容を入力してください"
        render new_yumyum_recipe_path
      end
    end

    def edit
      @recipe = Recipe.find(params[:id])
    end

    def update
      @recipe = Recipe.find(params[:id])
      if @recipe.update!(params_recipe)
        flash[:notice] = 'レシピを更新しました'
        redirect_to yumyum_recipe_path(@recipe.id)
      else
        flash[:alert] = 'レシピ内容を記載してください'
        render :edit
      end
    end

    def destroy
      @recipe = Recipe.find(params[:id])
      if @recipe.destroy
        flash[:notice] = 'レシピを削除しました'
        redirect_to new_yumyum_recipe_path
      end
    end

    def ensure_correct_recipe
      @recipe = Recipe.find(params[:id])
      if @recipe.chef_id != current_chef.id
        flash[:notice] = '権限がありません'
        redirect_to yumyum_recipes_path
      end
    end

    def create_only_chef
      if chef_signed_in?
        false
      else
        user_signed_in?
        flash[:notice] = 'このページはシェフ専用のページです'
        redirect_to yumyum_root_path
      end
    end

    def protect_show_page
      @recipe = Recipe.find(params[:id])
      if user_signed_in?
        if current_user.orders.where(user_id: current_user.id, recipe_id: @recipe.id).present?
          order = current_user.orders.where(user_id: current_user.id, recipe_id: @recipe.id)
          true if @recipe.id == order.first.recipe_id
        else
          flash[:alert] = 'レシピを購入してください'
          redirect_to "/yumyum/recipes/detail/#{@recipe.id}"
        end
      elsif chef_signed_in?
        if @recipe.chef_id == current_chef.id
          true
        else
          flash[:alert] = 'シェフが違います'
          redirect_to "/yumyum/recipes/detail/#{@recipe.id}"
        end
      else
        flash[:alert] = 'レシピを購入してください'
        redirect_to "/yumyum/recipes/detail/#{@recipe.id}"
      end
    end

    def search
      @recipes = Recipe.includes([:chef], [:genre]).search(params[:search]).page(params[:page]).per(12)
      @title = params[:search]
    end

    private

    def params_recipe
      params.require(:recipe).permit(:name, :food_stuff, :main_image, :first_process, :second_process, :third_process, :fourth_process,
                                     :first_image, :second_image, :third_image, :fourth_image, :advise, :chef_id, :genre_id)
    end
  end
end
