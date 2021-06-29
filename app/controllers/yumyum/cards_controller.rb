# frozen_string_literal: true

module Yumyum
  class CardsController < ApplicationController
    before_action :authenticate_user!, only: %i[new create]

    def new
      if user_signed_in? && current_user.card
        flash[:alert] = 'すでにクレジットカードを登録しています'
        redirect_to yumyum_root_path
      end
    end

    def create
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
      customer = Payjp::Customer.create(
        description: 'test',
        card: params[:token_id]
      )
      card = Card.new(
        customer_id: customer.id,
        token_id: params[:token_id],
        user_id: current_user.id
      )
      if card.save
        flash[:notice] = 'クレジットカードを登録しました'
        redirect_to yumyum_recipes_path
      else
        flash[:alert] = 'カード情報が間違っています'
        render new_yumyum_card_path
      end
    end
  end
end
