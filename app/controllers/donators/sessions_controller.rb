class Donators::SessionsController < ApplicationController

  def login
    @donator = Donator.new
  end

  def create
    @donator = Donator.find_by(email: params[:email])
    if @donator && @donator.authenticate(params[:password])
      session[:donator_id] = @donator.id
      redirect_to donator_path(@donator)
    else
      flash[:error] = "Incorrect Password or Username"
      redirect_to login_path
    end
  end

end
