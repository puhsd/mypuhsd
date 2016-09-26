class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # before_filter :require_login

  include Pundit
  # after_action :verify_authorized

  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # rescue_from Pundit::AuthorizationNotPerformedError, with: :user_not_authorized




  private


  def require_login
    unless current_user
      redirect_to '/auth/google_oauth2'
    end
  end

  # def user_not_authorized
  #   flash[:error] = "You are not authorized to perform this action."
  #   redirect_to(request.referrer || root_path)
  # end


  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:error] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
    redirect_to(request.referrer || root_path)
  end


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

end
