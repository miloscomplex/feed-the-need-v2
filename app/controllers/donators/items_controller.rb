class Donators::ItemsController < ApplicationController
  before_action :set_item, only: [:show]

  def index
    @items = Items.all
  end

  def edit
    @items = Item.find_by(id: params[:id])
  end

  def update
    @items = Item.find(params[:id])
    @items.update(items_params)
    redirect_to donator_path(@items.donator_id)
  end



  private

  def set_item
    @item = Item.find_by(id: params[:id])
  end

  def items_params
    params.require(:item).permit(:donator_id)
  end

end
