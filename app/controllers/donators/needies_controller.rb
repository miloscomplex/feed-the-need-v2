class Donators::NeediesController < ApplicationController
  include DonatorsHelper

  before_action :require_donator_login, :verify_donator

  def index
    @needies = Needy.all
  end

  def show
    if params[:id] && !Needy.exists?(params[:id])
      flash[:error] = "Person in need not found"
      redirect_to donator_needies_path

    else
      @needy = Needy.find_by(id: params[:id])
      # nested fields for donating needed items?
      #binding.pry
      @items = @needy.items
    end
  end

  private

  def verify_donator
    #binding.pry
    if current_user != Donator.find_by(id: params[:donator_id])
      flash[:error] = "Uh oh, something went wrong"
      redirect_to donator_path(current_user.id)
    end
  end

end
