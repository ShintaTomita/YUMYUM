class ApplicationController < ActionController::Base

  def forbid_login_user
    if user_signed_in?
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
end
