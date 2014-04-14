module SessionsHelper

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    current_user = user
  end

  def sign_out
    @current_user = nil
    cookies.delete(:remember_token)
  end
  
end
