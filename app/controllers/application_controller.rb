class ApplicationController < ActionController::Base
  #before_filter :authenticate_user!
  before_filter :update_sanitized_params, if: :devise_controller?

  protect_from_forgery with: :exception
  before_filter        :init_params
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, :alert => exception.message
  end

  def init_params
    @page = params[:page]||1
    @q = params[:q]
    params[:user_id] = current_user.try(:id) if current_user
  end

  def find_current_user
    if user_signed_in?
      params[:user_id]      = current_user.id
      params[:user_status]  = 1
    else
      params[:user_id]      = Session.find_by_session_id(cookies["_mori_session"]).try(:id)
      params[:user_status]  = 0
    end
  end

  private

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email,   :password, :password_confirmation)}
  end
end
