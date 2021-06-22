class Yumyum::ChefsController < ApplicationController
  before_action :authenticate_chef!,  only: [:edit, :update, :destroy]
  before_action :ensure_correct_chef, only: [:edit, :update, :destroy]
  before_action :exist_chef?,         only: [:show, :edit, :update, :destroy]
  before_action :forbid_login_user,   only: [:new, :create]

  def index
    @chefs = Chef.all
  end

  def show
    @chef = Chef.find(params[:id])
  end

  def new
    @chef = Chef.new
  end

  def create
    @chef = Chef.new(params_chef)
    if @chef.valid? && @chef.save!
      sign_in @chef
      flash[:notice] = "ようこそ#{@chef.name}さん　まずはプロフィールを完成させてください"
      redirect_to "/yumyum/chefs/#{@chef.id}/edit"
    else
      flash[:notice] = "メールアドレス、パスワードが間違っています"
      render new_yumyum_chef_path
    end
  end

  def edit
    @chef = Chef.find(params[:id])
  end

  def update
    @chef = Chef.find(params[:id])
    if @chef.update!(chef_profile)
      flash[:notice] = "プロフィールを更新しました"
      redirect_to yumyum_chef_path
    else
      render :edit
    end
  end

  def destroy
    @chef = Chef.find(params[:id])
    if @chef.destroy
      flash[:notice] = "アカウントを削除しました"
      redirect_to yumyum_root_path
    end
  end

  def chef_recipes
    @chef = Chef.find(params[:id])
    @recipes = @chef.recipes
  end

  def ensure_correct_chef
    @chef = Chef.find(params[:id])
    if @chef.id != current_chef.id
      flash[:alert] = "権限がありません"
      redirect_to yumyum_root_path
    end
  end



  private

  def params_chef
    params.require(:chef).permit(:name, :email, :password, :password_confirmation)
  end

  def chef_profile
    params.require(:chef).permit(:name, :email, :image, :shop_name, :address, :shop_tel, :shop_url, :introduction)
  end
end
