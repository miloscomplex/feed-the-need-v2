class Needy::ItemsController

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
end
