class ItemsController < ApplicationController
  def index
  end

  private
  def item_params
    params.require(:item).permit(:item_name, :text, :price, :category_id, :condition_id, :shipping_cost_id, :prefecture_id, :days_to_ship_id, :image).merge(user_id: current_user.id)
  end
end
