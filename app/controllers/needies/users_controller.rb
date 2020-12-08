class Needies::UsersController < ApplicationController
  before_action :require_login, except: [:login, :new, :create]
  before_action :set_needy, only: [:show]

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


  private

  def user_params
    params.require(:needy).permit(:name, :email, :password, :password_confirmation)
  end

  def require_login
    #binding.pry
    if !logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path
    elsif !is_needy?
      flash[:error] = "You must be registered as a person in need to access this section"
      redirect_to login_path
    end
  end

  def set_needy
    @needy = Needy.find_by(id: params[:id])
    if !@needy
      flash[:error] = "Needy not found"
      redirect_to login_path
    end
  end

end
