module SessionsHelper
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    digested_remember_token = User.digest(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: digested_remember_token)
  end

  def current_user?(user)
    current_user == user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out(user)
    current_user.update_attribute(:remember_token,
                    User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def redirect_back_or(default)
    #get from Gerry
  end

  def store_location
    #get from Gerry
  end
end
