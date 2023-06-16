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
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    card = Card.find_by(user_id: current_user.id)

    redirect_to new_card_path and return unless card.present?

    customer = Payjp::Customer.retrieve(card.customer_token)
    @card = customer.cards.first
  end

  def create
    @purchase_destination = PurchaseDestination.new(purchase_params)
    if @purchase_destination.valid?
      pay_item
      @purchase_destination.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def purchase_params
    params.require(:purchase_destination).permit(:postal_code, :prefecture_id, :locality, :address, :building_name, :phone).merge(user_id: current_user.id,
                                                                                                                                  item_id: params[:item_id])
  end

  def pay_item
    redirect_to new_card_path and return unless current_user.card.present?

    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    customer_token = current_user.card.customer_token # ログインしているユーザーの顧客トークンを定義
    Payjp::Charge.create(
      amount: @item.price,
      customer: customer_token, # 顧客のトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end
end
