class Donators::UsersController < ApplicationController
  #before_action :require_login, except: [:login]

  def new
    @donator = Donator.new
  end

  def create
    @donator = Donator.new(user_params)
    if @donator.save
      session[:user_id] = @donator.id
      redirect_to donator_path(@donator)
    else
      flash[:error] = "Something went wrong"
      render :new
    end
  end

  def show
    @donator = Donator.find_by(id: params[:id])
  end

  def login
    @donator = Donator.find_by(email: params[:email])
    if @donator && @donator.authenticate(params[:password])
      session[:donator_id] = @donator.id
      redirect_to donator_path(@needy)
    else
      flash[:notice] = "Incorrect Password or Username"
      redirect_to donators_login_path
    end
  end

  private

  def user_params
    params.require(:donator).permit(:name, :email, :password, :password_confirmation)
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to donators_login_path
    end
  end

  def logged_in?
    session.include? :donator_id
  end

end
