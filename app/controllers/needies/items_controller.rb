class Needies::ItemsController  < ApplicationController
  include NeediesHelper

  before_action :require_needy_login, :verify_user


  def new
    if params[:needy_id] && !Needy.exists?(params[:needy_id])
      redirect_to login_path, alert: "Person in need not found."
    else
      @item = Item.new(needy_id: params[:needy_id])
      @needy = Needy.find_by(id: params[:needy_id])
      @items = @needy.items
    end
  end

  def create
    # binding.pry
    @needy = Needy.find_by(id: params[:needy_id])
    @item = Item.new(item_params)

    if @item.save
      redirect_to needy_path(@item.needy_id)
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
    #  binding.pry
      if needy.nil?
        redirect_to login_path, alert: "Needy not found. items_controller"
      else
        @items = current_user.items
        @item = Item.new(needy_id: params[:needy_id])
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
      flash[:update] = "Item saved!"
      redirect_to needy_path(@item.needies_id)
    else
      render :edit
    end
    redirect_to needy_path(@item.needies_id)
  end

  private

  def item_params
    params.require(:item).permit(:name, :quantity, :needy_id)
  end

  def verify_user
    if current_user != Needy.find_by(id: params[:needy_id])
      flash[:error] = "Uh oh, something went wrong"
      redirect_to needy_path(current_user.id)
    end
  end

end
