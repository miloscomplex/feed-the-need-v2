module SessionsHelper
  # Logs in the given user.

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= Donator.find_by(id: session[:user_id]) || Needy.find_by(id: session[:user_id])
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !!current_user
  end

  # Logs out the current user.
  def logout!
    session.clear
    #edirect_to login_paths
    #session.delete(:user_id)
  end

end
