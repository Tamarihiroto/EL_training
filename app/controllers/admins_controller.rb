class AdminsController < ApplicationController
  before_action :set_user, only: %i(show edit update destroy)
  # before_action :admin_user
  before_action :forbid_delete_admin_user, only: %i(update destroy)

  def index
    @users = User.eager_load(:tasks).all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admins_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admins_path
    else
      render :edit
    end

  end

  def destroy
    if @user.destroy
      redirect_to admins_path
    else
      render :show
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:admin).permit(:name, :mail, :password, :password_confirmation, :admin)
  end

  # 管理者画面のアクセス制限
  def admin_user
    unless @current_user.admin?
      redirect_to tasks_path
    end
  end

  # 管理者がいなくならないように制限
  def forbid_delete_admin_user
    @users = User.where(admin: true)
    admin_limit = 1
    if @users.size == admin_limit && @user.admin?
      redirect_to admin_users_path
    end
  end
end
