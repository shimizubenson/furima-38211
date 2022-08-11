class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index ]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

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

  def show

  end

  def edit
    if current_user.id != @item.user_id || @item.order.present?
    redirect_to root_path   
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
     current_user.id == @item.user_id
     redirect_to root_path 
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :status_id, :category_id, :postage_id, :region_id,:day_to_ship_id, :price, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
