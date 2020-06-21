class OrderController < ApplicationController
  def create
    new_order = Order.create!(user_id: current_user.id,
                              order_date: Date.today,
                              order_type: params[:order_type],
                              order_status: "Not Delivered",
                              amount: params[:amount])
    OrderItem.active_order_items(current_user.id, new_order.id)
    flash[:notice] = "Order placed succesfully with Id: EATORD#{new_order.id}"
    redirect_to "/order"
  end

  def show
    if current_user.role.eql?("owner")
      @order = Order.find(params[:id])
    else
      @order = Order.of_user(current_user).find(params[:id])
    end
  end

  def update
    ensure_admin_logged_in
    order = Order.find(params[:id])
    if params[:state]
      order.order_status = "Delivered"
    else
      order.order_status = "Not Delivered"
    end

    order.save!
    redirect_to "/all_orders?dash=true"
  end

  def index
    @orders = @current_user.orders.order(id: :desc)
  end

  def display
    ensure_admin_logged_in
    @orders = Order.all
    @id = params[:id]

    if params[:dash]
      @order = nil
    else
      @order = Order.find_by(id: @id)
      if @id.eql?("")
        flash[:error] = "Order Id can't be empty"
        redirect_to "/all_orders?dash=true"
      elsif !@order
        flash[:error] = "Invalid Order Id"
        redirect_to "/all_orders?dash=true"
      else
      end
    end
  end

  def invoices
    ensure_owner_logged_in
    @from_date = params[:from_date]
    @to_date = params[:to_date]

    if params[:from].eql?("dash")
      @orders = nil
    else
      if @from_date.eql?("") or @to_date.eql?("")
        flash[:error] = "Date can't be blank"

        redirect_to "/invoices_statement?from_date=#{Date.new}&to_date=#{Date.new}"
      elsif @from_date > @to_date
        flash[:error] = "From Date can't be Greater than To Date"

        redirect_to "/invoices_statement?from_date=#{Date.new}&to_date=#{Date.new}"
      else
        @orders = Order.all.where("order_date >= ? and order_date <= ?", @from_date, @to_date)
      end
    end
  end
end
