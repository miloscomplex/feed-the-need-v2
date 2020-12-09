class Needies::UsersController < ApplicationController
  include NeediesHelper

  before_action :require_needy_login, except: [:new, :create]
  before_action :set_needy, only: [:show]

  def new
    @needy = Needy.new
  end

  def show
    # binding.pry
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

  def verify_user
    if current_user != Needy.find_by(id: params[:id])
      flash[:error] = "Uh oh, something went wrong"
      redirect_to login_path
    end
  end

  def set_needy
    if current_user != Needy.find_by(id: params[:id])
      flash[:error] = "Uh oh, something went wrong"
      redirect_to login_path
    else
      @needy = Needy.find_by(id: params[:id])
    end
  end

end
