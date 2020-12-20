class Donators::NeediesController < ApplicationController
  include DonatorsHelper

  before_action :require_donator_login, :verify_donator, only: [:index, :show, :donate_items]

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
    user_params[:items].each do |params|
      binding.pry
      item_id = params[0] #item_id
      item_donated = params[1]['id']
      if item_donated == "1" #if checked
        if item_id && !Item.exists?(item_id)
          flash[:error] = "Error, an item was not found"
          redirect_to donator_path(current_user.id)
        else
          # binding.pry
          @item = Item.find_by(id: item_id)
          @item.donator_id = @donator.id
          redirect_to donator_path(current_user.id), flash: { errror: "An error, while donating an item" } unless @item.save
        end
      end
    end
    flash[:alert] = "Items donated successfully!"
    redirect_to donator_path(current_user.id)
  end

  private

  def user_params
    params.permit(:donator_id, :items, items: [:id])
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
