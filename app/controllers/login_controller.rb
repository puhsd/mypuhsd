class LoginController < ApplicationController
  def index
    if current_user
      loggedInUser
    end
  end

  protected

  def loggedInUser
    redirect_to(current_user)
  end

  def loginScreen
    # redirect_to('/auth/google_oauth2')
  end



end
