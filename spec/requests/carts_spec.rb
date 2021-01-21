# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/carts', type: :request do
  let(:cart) { create :cart, :with_items }
  let(:product_item) { cart.product_items.first }

  before(:each) do
    login_as(cart.user, scope: :user)
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get cart_url(cart)
      expect(response).to be_successful
    end
  end

  describe 'PATCH /update' do
    it 'renders a successful response' do
      patch cart_url(id: cart.id, cart: { quantity: 3, product_id: product_item.product_id })
      expect(response).to be_successful
      expect(product_item.reload.quantity).to eq 3
      expect(product_item.reload.name).to include 'ProductCool'
    end
  end

  describe 'DELETE /destroy' do
    it 'renders a successful response' do
      delete cart_url(cart.id)
      expect(cart.reload.product_items.size.zero?).to eq true
    end
  end
end
