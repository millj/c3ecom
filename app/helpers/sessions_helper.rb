module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def finance_user?
    if signed_in?
      current_user.finance?
    else
      nil
    end
  end

  def demand_user?
    if signed_in?
      current_user.demand?
    else
      nil
    end
  end

  def customer_service_user?
    if signed_in?
      current_user.customer_service?
    else
      nil
    end
  end

  def direct_user?
    if signed_in?
      current_user.direct?
    else
      nil
    end
  end

  def direct2_user?
    if signed_in?
      current_user.direct2?
    else
      nil
    end
  end

  def store_user?
    if signed_in?
      current_user.store?
    else
      nil
    end
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user?(user)
    user == current_user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end

end
