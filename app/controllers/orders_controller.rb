class OrdersController < ApplicationController
  def show

  end

  def new
    @order = Order.new
  end

  def create
    order = Order.create!(permitted_params)
    redirect_to order_path(order.id)
  end

  private

  def permitted_params
    params.require(:order).permit(:name, :city, :street, :country, :province, :zip_code, :delivery_method, :payment_method)
  end
end
