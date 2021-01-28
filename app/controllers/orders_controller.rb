# frozen_string_literal: true

class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def new
    if current_user.cart.product_items.blank?
      redirect_to products_path
    else
      @order = Order.new
      render :new
    end
  end

  def create
    @order = Order.new(permitted_params.merge(user_id: current_user.id))
    if @order.valid?
      @order.product_items = current_user.cart.product_items
      @order.save!
      redirect_to order_path(@order.id)
    else
      flash[:error] = @order.errors.full_messages
      render :new
    end
  end

  def update
    @order = Order.find(params[:id])
    if params[:status] == 'confirmed' && @order.status == 'placed'
      @order.update(status: 'confirmed')
      current_user.cart.product_items.update_all(cart_id: nil)
      @order.product_items.each do |product_item|
        parent_product = product_item.product
        parent_product.update(quantity: parent_product.quantity - product_item.quantity)
      end
      flash[:notice] = "Order has been confirmed"
      redirect_to confirmed_order_path(@order.id)
    end
  end

  def confirmed
    render :confirmed
  end

  private

  def permitted_params
    params.require(:order).permit(:name, :city, :street, :country, :province, :zip_code, :delivery_method, :payment_method)
  end
end
