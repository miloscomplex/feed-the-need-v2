class SessionsController < ApplicationController

  def login

  end

  def create
    #how to make this handle two different forms?
    @donator = Donator.find_by(name: params[:user][:name])
    @needy = Needy.find_by(name: params[:user][:name])
    if @donator && @donator.authenticate(params[:user][:password])
      session[:user_id] = @donator.id
      redirect_to donator_path(@donator)
    else if @needy && @needy.authenticate(params[:user][:password])
        session[:user_id] = @needy.id
        redirect_to needy_path(@needy)
      else
      flash[:notice] = "Incorrect Password or Username"
      redirect_to sessions_login_path
    end
  end

  def logout
    session.delete :user_id
  end

end
