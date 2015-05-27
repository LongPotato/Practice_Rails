module SessionsHelper
  def sign_in(user)
    remember_token = User.new_token   #give user a new token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encript_token(remember_token))
    @current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  #retrieve current_user for each request
  def current_user
  	remember_token = User.encript_token(cookies[:remember_token])   #retrieve stored token
  	@current_user ||= User.find_by(remember_token: remember_token)
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
  	#because Rails create new instance of controller for each request, we cant new use @current_user
    current_user.update_attribute(:remember_token, User.encript_token(User.new_token))   #change current token to new token
    cookies.delete(:remember_token)
    current_user = nil
  end
end
