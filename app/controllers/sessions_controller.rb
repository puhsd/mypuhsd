class SessionsController < ApplicationController
  # skip_before_filter :require_login

  def create
    user = authenticate_with_google

    if user
      session[:user_id] = user.id
      flash[:notice] = "Login was successfull"
    else
       flash[:notice] = "User not found"
    end
      redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been successfully logged out."
    redirect_to root_path
  end

  private
  def authenticate_with_google
    if flash[:google_sign_in_token].present?

      auth = GoogleSignIn::Identity.new(flash[:google_sign_in_token])
      user = User.google_sign_in(auth)
      return user
    end
  end

end
