class UsersController < ApplicationController
  before_action :set_user, only: %i(show edit update destroy)
  # before_action :ensure_admin_user, only: %i(index edit)

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_admin_user
    if @current_user.admin == false
      redirect_to tasks_path
    end
  end
end
