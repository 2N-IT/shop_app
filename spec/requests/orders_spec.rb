# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders', type: :request do

  describe 'POST /create' do
    let(:cart) { create :cart, :with_items }
    let(:product_item) { cart.product_items.first }

    before(:each) do
      login_as(cart.user, scope: :user)
    end
    it 'does not do anything with unpermitted params' do
      post orders_url(user: { id: cart.user.id, admin: true }, order: { whatever: 'me hacker' })
      expect(response).to be_successful
      expect(cart.user.reload.admin).to eq false
      expect(Order.all.size).to eq 0
    end
  end

  describe 'GET /new' do
    let(:cart) { create :cart }
    before(:each) do
      login_as(cart.user, scope: :user)
    end
    it 'does not allow to be accessed when cart is empty' do
      get new_order_url
      expect(response.location).to eq("http://www.example.com/products")
    end
  end

  describe 'PATCH /update' do
    let(:cart) { create :cart, :with_items }
    let(:order) { create :order, user: cart.user }
    before(:each) do
      login_as(cart.user, scope: :user)
    end
    context "with placed status" do
      it 'changes the status to confirmed' do
        expect { patch order_url(order.id, status: "confirmed") }.to change { order.reload.status }.from("placed").to("confirmed")
      end
    end
  end
end
