# class OrdersController < ApplicationController
#   def index
#     @item = Item.find(params[:item_id])
#   end

#   private

#   def item_params
#     params.require(:item).permit(:image, :item_name, :item_info, :item_category_id, :item_sales_status_id, :item_shipping_fee_status_id, :item_prefecture_id, :item_scheduled_delivery_id, :item_price).merge(user_id: current_user.id)
#   end
# end
