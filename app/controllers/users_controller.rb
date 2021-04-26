class UsersController < ApplicationController
  before_action :set_user, only: %i(show edit update destroy)
  before_action :logged_in_user

  def index
    @users = User.eager_load(:tasks).all
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
end
