class ApplicationController < ActionController::Base
  before_action :current_user
  include SessionsHelper

  private

  def logged_in_user
    unless logged_in?
      redirect_to login_path
    end
  end
end
