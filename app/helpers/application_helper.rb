module ApplicationHelper

  def which_user?
    session[:user_type]
  end

  def is_donator?
    which_user? == :donator 
  end
end
