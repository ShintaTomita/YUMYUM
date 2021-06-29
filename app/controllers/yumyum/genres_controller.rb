class Yumyum::GenresController < ApplicationController

  def show
    @genre = Genre.find(params[:id])
    @recipes = @genre.recipes.page(params[:page]).per(12)
  end
end
