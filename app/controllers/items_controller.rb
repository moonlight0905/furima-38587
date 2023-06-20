class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_item, only: [:show, :edit, :update, :correct_item, :destroy]
  before_action :correct_item, only: [:edit, :destroy]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
    @categories = Category.new
    @maincategories = Category.all.order('id ASC').limit(13)
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
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render 'edit'
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def search
    item = Category.find(params[:id])
    children_item = item.children
    render json: { item: children_item }
  end

  def correct_item
    return unless !(user_signed_in? && @item.user == current_user) || @item.purchase

    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :text, :price, :condition_id, :shipping_cost_id, :prefecture_id,
                                 :days_to_ship_id, { images: [] }).merge(user_id: current_user.id, category_id: params[:category_id])
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
