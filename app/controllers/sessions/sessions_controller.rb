class Sessions::SessionsController < ApplicationController

  def login
    #flash.now[:messages] = "Incorrect Password or Username"
    # @donator = Donator.new
  end

  def create
    @donator = Donator.find_by(email: params[:email])
    @needy = Needy.find_by(email: params[:email])
    if @donator && @donator.authenticate(params[:password])
      session[:user_id] = @donator.id
      session[:user_type] = :donator
      redirect_to donator_path(@donator)
    elsif @needy && @needy.authenticate(params[:password])
      session[:user_id] = @needy.id
      session[:user_type] = :needy
      redirect_to needy_path(@needy)
    else
      flash[:error] = "Incorrect Password or Username"
      redirect_to login_path
    end
  end

  def logout
    logout!
    redirect_to root_path
  end

end
