class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create] 
  before_action :set_item, only: [:index, :create]


  def index
    if @item.user == current_user
      redirect_to root_path
    elsif @item.purchase
      redirect_to root_path
    else
    @purchase_destination = PurchaseDestination.new
    end
  end

  def create
    @purchase_destination = PurchaseDestination.new(purchase_params)
    if @purchase_destination.valid?
      pay_item
      @purchase_destination.save
      return redirect_to root_path
    else
      render :index
    end 
  end


  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def purchase_params
    params.permit(:postal_code, :prefecture_id, :locality, :address, :building_name, :phone).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price, 
      card: purchase_params[:token], 
      currency: 'jpy' 
    )
  end

end
