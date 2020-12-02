class NeediesController < ApplicationController
  before_action :require_login, except: [:login]

  def new
    @needy = Needy.new
  end

  def create
    @needy = Needy.new(user_params)
    if @needy.save
      session[:needy_id] = @needy.id
      redirect_to needy_path(@needy)
    else
      redirect_to needies_new_path
    end
  end

  def index
    @needy = Needy.find_by(id: params[:id])
  end

  def login
    @needy = Needy.find_by(email: params[:email])
    if @needy && @needy.authenticate(params[:password])
      session[:needy_id] = @needy.id
      redirect_to needy_path(@needy)
    else
      flash[:notice] = "Incorrect Password or Username"
      redirect_to needy_login_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to needies_login_path
  end

  def logged_in?
    session.include? :needy_id
  end

end
