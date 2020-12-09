class Donators::NeediesController < ApplicationController
  include DonatorsHelper

  before_action :require_donator_login
  
  def index
    @needies = Needy.all
  end

  def show
    if params[:id] && !Needy.exists?(params[:id])
      redirect_to donator_needies_path, flash[error]: "Person in need not found"
    else
      @needy = Needy.find_by(id: params[:id])
      # nested fields for donating needed items?
      #binding.pry
      @items = @needy.items
    end
  end

end
