class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]

  def index
    @order_order_information = OrderOrderInformation.new
    if current_user.id == @item.user_id  || @item.order.present?
      redirect_to root_path
    end
  end

  def create
    @order_order_information = OrderOrderInformation.new(order_params)
    if @order_order_information.valid?
      pay_item
      @order_order_information.save
      redirect_to root_path
    else
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

  def set_item
    @item = Item.find(params[:item_id])
  end
end
