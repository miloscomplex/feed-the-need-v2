class Needies::ItemsController  < ApplicationController
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to needy_path(@item.needies_id)
  end

  def show
    @items = Item.all
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to needy_path(@item.needies_id)
  end

  private

  def item_params
    params.require(:item).permit(:name, :quantity, :needy_id)
  end

end
