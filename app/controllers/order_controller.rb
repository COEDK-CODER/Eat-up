class OrderController < ApplicationController
  def create
    new_order = Order.create!(user_id: current_user.id,
                              order_date: Date.today,
                              order_type: params[:order_type],
                              order_status: "Not Delivered",
                              amount: params[:amount])
    OrderItem.active_order_items(current_user.id, new_order.id)
    redirect_to "/order"
  end

  def show
    if current_user.role.eql?("owner")
      @order = Order.find(params[:id])
    else
      @order = Order.where(user_id: current_user.id).find(params[:id])
    end
  end

  def update
    order = Order.find(params[:id])
    if params[:state]
      order.order_status = "delivered"
    else
      order.order_status = "Not Delivered"
    end

    order.save!
    redirect_to "/all_orders"
  end

  def display
    if current_user.role.eql?("owner")
      render "display"
    else
      redirect_to "/menu"
    end
  end
end
