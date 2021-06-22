class ApplicationController < ActionController::Base


  def forbid_login_user
    if user_signed_in? or chef_signed_in?
      flash[:notice] = "すでにログインしています"
      redirect_to yumyum_root_path
    end
  end

  protected def after_sign_in_path_for(resource_or_scope)
    yumyum_top_index_path
  end

  protected def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def exist_chef?
    unless Chef.exists?(params[:id])
      flash[:alert] = "存在しないページです"
      redirect_to new_yumyum_chef_path
    end
  end

  def exist_user?
    unless User.exists?(params[:id])
      flash[:alert] = "存在しないページです"
      redirect_to new_yumyum_user_path
    end
  end

  def exist_recipe?
    unless Recipe.exists?(params[:id])
      flash[:alert] = "存在しないページです"
      redirect_to yumyum_recipes_path
    end
  end

  def ensure_correct_chef
    @chef = Chef.find(params[:id])
    if @chef.id != current_chef.id
      flash[:alert] = "権限がありません"
      redirect_to yumyum_root_path
    end
  end
end
