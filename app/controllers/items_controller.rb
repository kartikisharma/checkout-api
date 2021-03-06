class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]

  # GET /items
  def index
    @items = Item.all
    json_response(@items)
  end

  # POST /items
  def create
    @item = Item.create!(item_params)
    json_response(@item, :created)
  end

  # GET /items/:barcode
  def show
    json_response(@item)
  end

  # PUT /items/:barcode
  def update
    @item.update(item_params)
    head :no_content
  end

  # DELETE /items/:barcode
  def destroy
    @item.destroy
    head :no_content
  end

  private

  def item_params
    params.permit(:name, :barcode, :available)
  end

  def set_item
    @item = Item.find_by!(barcode: params[:barcode])
  end
end
