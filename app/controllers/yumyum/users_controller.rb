# frozen_string_literal: true

module Yumyum
  class UsersController < ApplicationController
    before_action :authenticate_user!,  only: %i[index show edit update destroy]
    before_action :exist_user?,         only: %i[show edit update destroy]
    before_action :ensure_correct_user, only: %i[show edit update destroy]
    before_action :forbid_login_user,   only: %i[new create]

    def show
      @user = User.find(params[:id])
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(params_user)
      if @user.valid?(:step1) && @user.save!
        sign_in @user
        flash[:notice] = "ようこそ#{current_user.name}さん まずはプロフィールを完成させてください"
        redirect_to "/yumyum/users/#{current_user.id}/edit"
      else
        flash[:notice] = 'メールアドレス、パスワードが間違っています'
        render new_yumyum_user_path
      end
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if @user.update!(user_profile)
        flash[:notice] = 'プロフィールを更新しました'
        redirect_to yumyum_root_path
      else
        render :edit
      end
    end

    def destroy
      @user = User.find(params[:id])
      if current_user.destroy
        flash[:notice] = 'アカウントを削除しました'
        redirect_to yumyum_root_path
      end
    end

    def ensure_correct_user
      @user = User.find(params[:id])
      if @user.id != current_user.id
        flash[:alert] = '権限がありません'
        redirect_to yumyum_root_path
      end
    end

    def card
      @user = User.find(params[:id])
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
      card = Card.find_by(user_id: current_user.id)
      if card.present?
        customer = Payjp::Customer.retrieve(card.customer_id)
        @card = customer.cards.first
      else
        flash[:notice] = 'クレジットカードを登録してください'
        redirect_to new_yumyum_card_path
      end
    end

    def purchase_recipes
      @user = User.find(params[:id])
      @orders = Order.where(user_id: @user.id).page(params[:page]).per(12)
    end

    private

    def params_user
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def user_profile
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :age, :sex)
    end
  end
end
