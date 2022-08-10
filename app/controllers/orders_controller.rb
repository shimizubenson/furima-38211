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
      @order_order_information.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render "orders/index"  
    end
  end

  private

  

  def order_params
    params.require(:order_order_information).permit(:post_code, :region_id, :city, :address, :building_name, :phone_number)
  end
end
