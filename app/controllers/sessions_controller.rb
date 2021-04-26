class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(mail: params[:session][:mail].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to tasks_path
    else
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path
  end
end
