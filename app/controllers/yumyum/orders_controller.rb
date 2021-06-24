class Yumyum::OrdersController < ApplicationController
  before_action :authenticate_user!, only:[:create]

  def create
    return redirect_to new_yumyum_card_path unless current_user.card.present?
    @recipe = Recipe.find(params[:recipe_id])
    @order = current_user.orders.where(user_id: current_user.id, recipe_id: @recipe.id).first
    if @order.present?
      if @recipe.id == @order.recipe_id
        flash[:notice] = "すでに購入済みです"
        return redirect_to yumyum_recipe_path(@recipe.id)
      end
    else
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      customer_id = current_user.card.customer_id
      Payjp::Charge.create(
        amount: @recipe.price,
        customer: customer_id,
        currency: 'jpy'
      )
      current_user.orders.create(recipe_id: @recipe.id)
      flash[:notice] = "ありがとうございます、レシピを購入しました"
      redirect_to yumyum_recipe_path(@recipe.id)
    end
  end
end
