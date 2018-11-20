module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  #retuerns the current loggeed in user
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id:cookies.signed[:user_id])
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
    @current_user
  end
  # returns true if the user is logged in,false otherwise
  # remebers a user in a persistent sessions
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  def logged_in?
    !current_user.nil?
  end
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  def forget(user)
    user.forget
    cookies.delete(:remeber_token)
    cookies.delete(:user_id)
  end
end
