class NeediesController < ApplicationController
  before_action :logged_in?, only: [:homepage]

  def new
    @needy = Needy.new
  end

  def create
    @needy = Needy.new(user_params)
    if @needy.save
      session[:user_id] = @needy.id
      redirect_to needy_path(@needy)
    else
      redirect_to needies_new_path
    end
  end

  def homepage
    @needy = Needy.find_by(id: params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

  def logged_in?
    redirect_to needies_login_path unless session.include? :user_id
  end
end
