class Sessions::SessionsController < ApplicationController

  def login
    @donator = Donator.new
  end

  def create
    @donator = Donator.find_by(email: params[:email])
    @needy = Needy.find_by(email: params[:email])
    if @donator && @donator.authenticate(params[:password])
      session[:user_id] = @donator.id
      session[:user_type] = :donator
      binding.pry
      redirect_to donator_path(@donator)
    elsif @needy && @needy.authenticate(params[:password])
        session[:user_id] = @donator.id
        session[:user_type] = :needy
        redirect_to donator_path(@donator)
    else
      flash[:messages] = "Incorrect Password or Username"
      redirect_to login_path
    end
  end

end
