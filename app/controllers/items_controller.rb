class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index ]
  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to  action: :index
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :status_id, :category_id, :postage_id, :region_id,:day_to_ship_id, :price, :image).merge(user_id: current_user.id)
  end

end
