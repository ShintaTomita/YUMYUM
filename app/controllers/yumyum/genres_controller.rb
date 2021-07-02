# frozen_string_literal: true

module Yumyum
  class GenresController < ApplicationController
    def show
      @genre = Genre.find(params[:id])
      @recipes = @genre.recipes.includes([:chef]).page(params[:page]).per(12)
    end
  end
end
