class Donators::UsersController < ApplicationController
  include DonatorsHelper

  before_action :require_donator_login, except: [:login, :new, :create]
  before_action :set_donator, only: [:show, :edit, :update]

  def new
    @donator = Donator.new
  end

  def create
    @donator = Donator.new(user_params)
    if @donator.save
      session[:user_id] = @donator.id
      session[:user_type] = :donator
      redirect_to donator_path(@donator)
    else
      # flash[:messages] = "Something went wrong"
      render :new
    end
  end

  def index
    if current_user
      redirect_to donator_path(current_user.id)
    end
    #donator helper redirects with message if not logged_in
  end

  def show
    @needies = Needy.all
  end

  def update
    if params[:donator][:donate_items]&.present?
      binding.pry
      # process add donator_id to items
      redirect_to donator_path(@donator)
    else
      @donator.update(user_params)
      redirect_to donator_path(@donator)
    end
  end

  def destroy
    @donaotr.destroy
    redirect_to needy_path(@needy)
  end

  private

  def user_params
    params.require(:donator).permit(:name, :email, :about, :password, :password_confirmation, :donate_items )
  end

  def set_donator
    if current_user != Donator.find_by(id: params[:id])
      flash[:error] = "Uh oh, something went wrong"
      redirect_to login_path
    else
      @donator = Donator.find_by(id: params[:id])
    end
  end

end
