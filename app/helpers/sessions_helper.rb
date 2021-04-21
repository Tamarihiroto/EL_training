module SessionsHelper
  ログイン
  def log_in(user)
    session[:user_id] = user.id
  end

  # ログイン判定
  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
end
