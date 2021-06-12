class Yumyum::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update]
  before_action :ensure_correct_user, only: [:show, :edit, :update]
  before_action :forbid_login_user, only: [:new, :create]

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
      flash[:notice] = "ようこそ#{current_user.name}さん"
      flash[:alert] = "まずはプロフィールを完成させてください"
      redirect_to "/yumyum/users/#{current_user.id}/edit"
    else
      flash[:notice] = "メールアドレス、パスワードが間違っています"
      render "yumyum/users/new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
  if @user.update!(user_profile)
      flash[:notice] = "プロフィールを更新しました"
      redirect_to yumyum_root_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if current_user.destroy
      flash[:notice] = "アカウントを削除しました"
      redirect_to yumyum_root_path
    end
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to yumyum_root_path
    end
  end

  private
  def params_user
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_profile
    params.require(:user).permit(:name, :email,:password,:password_confirmation, :image, :age, :sex)
  end
end
