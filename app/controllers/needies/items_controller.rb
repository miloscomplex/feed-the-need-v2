class Needies::ItemsController  < ApplicationController
  include NeediesHelper

  before_action :require_needy_login, :verify_user


  def new
    if params[:needy_id] && !Needy.exists?(params[:needy_id])
      redirect_to login_path, alert: "Person in need not found."
    else
      @item = Item.new
      @items = @needy.items
    end
  end

  def create
    binding.pry

    @needy.items.build([{name: :name_0, quantity: :quantity_0}, {name: :name_1, quantity: :quantity_1}, {name: :name_2, quantity: :quantity_2}])
    @item = Item.new(item_params)
    if @item.save
      redirect_to needy_path(@item.needy_id)
    else
      render :new
    end
  end

  def show
    redirect_to needy_path(@needy)
    #binding.pry
  end

  def edit
    if params[:needy_id]
      needy = Needy.find_by(id: params[:needy_id])
    #  binding.pry
      if needy.nil?
        redirect_to login_path, flash:  error: "Needy not found. items_controller" }
      else
        @items = current_user.not_donated
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
      flash[:alert] = "Item saved!"
      redirect_to needy_path(@item.needies_id)
    else
      render :edit
    end
    redirect_to needy_path(@item.needies_id)
  end

  def destroy
    @needy.items.destroy_all
    redirect_to needy_path(@needy)
  end

  private

  def item_params
    params.require(:item).permit(:needy_id, :name_0, :quantity_0, :name_1, :quantity_1, :name_2, :quantity_2)
  end

  def verify_user
    if current_user != Needy.find_by(id: params[:needy_id])
      flash[:error] = "Uh oh, something went wrong"
      redirect_to needy_path(current_user.id)
    else
      @needy = Needy.find_by(id: params[:needy_id])
    end
  end

end
