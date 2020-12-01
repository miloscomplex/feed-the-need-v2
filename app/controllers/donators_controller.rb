class DonatorsController < ApplicationController
  before_action :logged_in?, only: [:homepage]

  def new
    @donator = Donator.new
  end

  def create
    @donator = Donator.new(user_params)
    if @donator.save
      session[:user_id] = @donator.id
      redirect_to donator_path(@donator)
    else
      redirect_to donators_new_path
    end
  end

  def homepage
    @donator = Donator.find_by(id: params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

  def logged_in?
    redirect_to donators_login_path unless session.include? :user_id
  end
end
