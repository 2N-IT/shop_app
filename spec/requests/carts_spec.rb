# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/carts', type: :request do
  let(:user) { User.create(admin: false, email: 'email@admin.pl', password: '123blabla345') }

  before(:each) do
    sign_in(user)
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      cart = Cart.create!
      get cart_url(cart)
      expect(response).to be_successful
    end
  end

  describe 'PATCH /update' do
    it 'renders a successful response' do
      cart = Cart.create!(user: user)
      product = Product.create(name: 'test', price: 12.12, quantity: 12)
      patch cart_url(id: cart.id, cart: { quantity: 3, product_id: product.id })
      expect(response).to be_successful
      expect(cart.reload.product_items.first.quantity).to eq 3
      expect(cart.reload.product_items.first.name).to eq 'test'
    end
  end

  describe 'DELETE /destroy' do
    it 'renders a successful response' do
      cart = Cart.create!(user: user)
      ProductItem.create(name: 'test', cart: cart)
      delete cart_url(cart.id)
      expect(cart.reload.product_items.size.zero?).to eq true
    end
  end
end
