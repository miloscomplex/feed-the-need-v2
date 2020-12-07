class Needies::ItemsController  < ApplicationController

  def new
    if params[:needy_id] && !Needy.exists?(params[:needy_id])
      redirect_to login_path, alert: "Artist not found."
    else
      @item = Item.new(needy_id: params[:needy_id])
    end
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to needy_path(@item.needies_id)
    else
      render :new
    end
  end

  def show
    @items = Item.all
    #binding.pry
  end

  def edit
    if params[:needy_id]
      needy = Needy.find_by(id: params[:needy_id])
      if needy.nill?
        redirect_to login_path, alert: "Needy not found."
      else
        @item = needy.items.find_by(id: params[:id])
        @needy = needy
        redirect_to needy_path(needy), alert: "Item not found." if @needy.nil?
      end
    else
      @item = Item.find(params[:id])
    end
  end

  def update
    @item = Item.find(params[:id])

    @item.update(item_params)

    if @item.save
      redirect_to needy_path(@item.needies_id)
    else
      render :redirect_to
    end
    redirect_to needy_path(@item.needies_id)
  end

  private

  def item_params
    params.require(:item).permit(:name, :quantity, :needy_id)
  end

end
