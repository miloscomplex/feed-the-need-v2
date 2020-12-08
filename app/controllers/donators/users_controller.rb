class Donators::UsersController < ApplicationController
  before_action :require_login, except: [:login, :new, :create]
  before_action :set_donator, only: [:show]

  def new
    @donator = Donator.new
  end

  def create
    @donator = Donator.new(user_params)
    if @donator.save
      session[:user_id] = @donator.id
      redirect_to donator_path(@donator)
    else
      flash[:messages] = "Something went wrong"
      render :new
    end
  end

  def show
    @needies = Needy.all
  end

  private

  def user_params
    params.require(:donator).permit(:name, :email, :password, :password_confirmation)
  end

  def require_login
    if !logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path
    elsif !is_donator?
      flash[:error] = "You must be registered as a donator access this section"
    end
  end

  def set_donator
    @donator = Donator.find_by(id: params[:id])
    if !@donator
      flash[:error] = "Donator does not exist!"
      redirect_to login_path
    end
  end

end
