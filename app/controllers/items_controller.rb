class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :correct_item, only: [:edit]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    if @item.save
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def correct_item
    @item = Item.find(params[:id])
    unless @item.user == current_user
      redirect_to root_path
    end 
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :text, :price, :category_id, :condition_id, :shipping_cost_id, :prefecture_id,
                                 :days_to_ship_id, :image).merge(user_id: current_user.id)
  end
end
