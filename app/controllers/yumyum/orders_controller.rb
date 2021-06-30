# frozen_string_literal: true

module Yumyum
  class OrdersController < ApplicationController
    before_action :authenticate_user!, only: [:create]

    def create
      return redirect_to new_yumyum_card_path if current_user.card.blank?

      @recipe = Recipe.find(params[:recipe_id])
      @order = current_user.orders.where(user_id: current_user.id, recipe_id: @recipe.id).first
      if @order.present?
        if @recipe.id == @order.recipe_id
          flash[:notice] = 'すでに購入済みです'
          redirect_to yumyum_recipe_path(@recipe.id)
        end
      else
        Payjp.api_key = ENV['PAYJP_SECRET_KEY']
        customer_id = current_user.card.customer_id
        Payjp::Charge.create(
          amount: @recipe.genre.price,
          customer: customer_id,
          currency: 'jpy'
        )
        current_user.orders.create(recipe_id: @recipe.id)
        flash[:notice] = 'ありがとうございます、レシピを購入しました'
        redirect_to yumyum_recipe_path(@recipe.id)
      end
    end
  end
end
