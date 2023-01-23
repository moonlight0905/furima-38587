class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save
     redirect_to root_path
    else
     render "new"
    end
  end

  private
  def item_params
    params.require(:item).permit(:item_name, :text, :price, :category_id, :condition_id, :shipping_cost_id, :prefecture_id, :days_to_ship_id, :image).merge(user_id: current_user.id)
  end

end
