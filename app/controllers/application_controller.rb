class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :login_required

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  private

  def login_required
    redirect_to new_sessions_path unless current_user
  end
end
