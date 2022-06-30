class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    if params[:user_id]
      user = find_user
      items = user.items
    else
      items = Item.all 
    end
    render json: items, include: :user
  end

  def show
    item = find_item 
    render json: item
  end

  def create
    user = find_user
    item = user.items.create(item_params)
    render json: item, status: :created  
  rescue ActiveRecord::RecordInvalid => invalid
    render json: {errors: invalid.record.errors}, status: :unprocessable_entity
  end

  private

  def find_item
    Item.find(params[:id])
  end

  def find_user
    User.find(params[:user_id])
  end

  def record_not_found
    render json: {error: "Could not find this item"}, status: :not_found
  end

  def item_params
    params.permit(:name, :description, :price)
  end

end
