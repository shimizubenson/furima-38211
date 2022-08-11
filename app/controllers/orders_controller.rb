class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    @item = Item.find(params[:item_id])
    @order_order_information = OrderOrderInformation.new
    @order = Order.new
  end
  

  def create
    @order_order_information = OrderOrderInformation.new(order_params)
    if @order_order_information.valid?
      @item = Item.find(params[:item_id])
      Payjp.api_key = "sk_test_328cbe14cbd463697e91390c" 
      Payjp::Charge.create(
        amount: @item.price, # 商品の値段
        card: order_params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
      @order_order_information.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render "orders/index"  
    end
  end

  private

  

  def order_params
    params.require(:order_order_information).permit(:post_code, :region_id, :city, :address, :building_name, :phone_number).merge(item_id: params[:item_id], user_id: current_user.id,token: params[:token])
  end
end