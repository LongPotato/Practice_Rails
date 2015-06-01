module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
    remember(user)
  end

  # Remembers a user in a persistent session.
  def remember(user)
    remember_token = User.new_token   #give user a new token
    user.update_attribute(:remember_token, User.encript_token(remember_token))
    cookies.permanent[:remember_token] = remember_token
    cookies.permanent.signed[:user_id] = user.id
    @current_user = user
  end

  # Returns the user corresponding to the remember token cookie.
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      token = User.encript_token(cookies[:remember_token])
      if user && user.authenticated_token(token)
        log_in user
        @current_user = user
      end
    end
  end

  def current_user?(user)
    @current_user == user
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    current_user.update_attribute(:remember_token, User.encript_token(User.new_token))   #change current token to new token
    cookies.delete(:remember_token)
    session.delete(:user_id)
    @current_user = nil
  end

end
