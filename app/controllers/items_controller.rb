class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end

  def create
    Item.create(item_params)
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :status_id, :category_id, :region_id,:day_to_ship_id, :price, :image).merge(user_id: current_user.id)
  end

end
