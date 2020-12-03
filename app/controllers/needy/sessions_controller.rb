class Needy::SessionsController < ApplicationController

  def login
    @needy = Needy.new
  end

  def create
    @needy = Needy.find_by(email: params[:email])
    if @needy && @needy.authenticate(params[:password])
      session[:user_id] = @needy.id
      redirect_to needy_path(@needy)
    else
      flash[:messages] = "Incorrect Password or Username"
      redirect_to needy_login_path
    end
  end

end
