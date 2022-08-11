class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    @item = Item.find(params[:item_id])
    @order_order_information = OrderOrderInformation.new
    @order = Order.new
    if current_user.id == @item.user_id  || @item.order.present?
      redirect_to root_path
    end
  end
  

  def create
    @order_order_information = OrderOrderInformation.new(order_params)
    if @order_order_information.valid?
      @item = Item.find(params[:item_id])
      pay_item
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

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] 
      Payjp::Charge.create(
        amount: @item.price, 
        card: order_params[:token],   
        currency: 'jpy'                 
      )
  end
end
