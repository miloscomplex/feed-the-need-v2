module ApplicationHelper

  def which_user?
    session[:user_type]
  end
end
