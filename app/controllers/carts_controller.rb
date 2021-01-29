# frozen_string_literal: true

class CartsController < ApplicationController
def update
  product_in_cart = cart.product_items.find_by(product_id: params[:cart][:product_id])
  new_quantity = params[:cart][:quantity].to_i
  if product_in_cart
    product_in_cart.destroy if new_quantity.zero?

    product_in_cart.update(quantity: new_quantity) if new_quantity <= product_in_cart.product.quantity
  else
    ProductItem.create(
      cart: cart,
      product: product,
      name: product.name,
      price: product.price,
      quantity: new_quantity
    )
  end
  head :no_content
end

  def destroy
    cart.product_items.destroy_all
    redirect_to products_path
  end

  def show

  end

  private

  def cart
    @cart ||= user_signed_in? ? current_user.cart : Cart.find_by(params[:id])
  end

  def product
    @product ||= Product.find(params[:cart][:product_id])
  end
end
