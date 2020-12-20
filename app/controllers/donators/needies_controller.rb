class Donators::NeediesController < ApplicationController
  include DonatorsHelper

  before_action :require_donator_login, :verify_donator

  def index
    @needies = Needy.all
  end

  def show
    if params[:id] && !Needy.exists?(params[:id])
      flash[:error] = "Person in need not found"
      redirect_to donator_path(current_user.id)
    else
      @needy = Needy.find_by(id: params[:id])
      # nested fields for donating needed items?
      #binding.pry
      @items = @needy.not_donated
    end
  end

  def donate_items
    binding.pry
  end

  private

  def user_params
    params.permit(:items, items: [:donator_id])
  end

  def verify_donator
    #binding.pry
    if current_user != Donator.find_by(id: params[:donator_id])
      flash[:error] = "Uh oh, something went wrong"
      redirect_to donator_path(current_user.id)
    else
      @donator = Donator.find_by(id: params[:donator_id])
    end
  end

end
