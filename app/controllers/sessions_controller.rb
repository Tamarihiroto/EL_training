class SessionsController < ApplicationController
  skip_before_action :logged_in_user, only: %i(new create)
  before_action :forbid_login_path, only: %i(new create)

  def new
  end

  def create
    user = User.find_by(mail: params[:session][:mail])
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to tasks_path
    else
      flash.now[:danger] = 'メールアドレスかパスワードが間違ってます'
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path
  end

  private

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def forbid_login_path
    if logged_in?
      redirect_to tasks_path
      flash.now[:danger] = 'ログイン中です'
    end
  end
end
