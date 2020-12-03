class Donators::SessionsController < ApplicationController

  def login
    @donator = Donator.new
  end

  def create
    @donator = Donator.find_by(email: params[:email])
    if @donator && @donator.authenticate(params[:password])
      session[:donator_id] = @donator.id
      redirect_to needy_path(@donator)
    else
      flash[:messages] = "Incorrect Password or Username"
      redirect_to donators_login_path
    end
  end

end
