class Needies::UsersController < ApplicationController
  before_action :require_login, except: [:login, :new, :create]

  def new
    @needy = Needy.new
  end

  def create
    @needy = Needy.new(user_params)
    if @needy.save
      session[:needy_id] = @needy.id
      redirect_to needy_path(@needy)
    else
      redirect_to new_needy_path
    end
  end

  def index
    @needy = Needy.find_by(id: params[:id])
  end

  def show
    @needy = Needy.find_by(id: params[:id])
  end

  private

  def user_params
    params.require(:needy).permit(:name, :email, :password, :password_confirmation)
  end

  def require_login
    binding.pry
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path
    end
  end

end
