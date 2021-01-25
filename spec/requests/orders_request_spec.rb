# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  let(:cart) { create :cart, :with_items }
  let(:product_item) { cart.product_items.first }

  before(:each) do
    login_as(cart.user, scope: :user)
  end

  describe 'POST /create' do
    it 'does not do anything with unpermitted params' do
      post orders_url(user: { id: cart.user.id, admin: true }, order: { whatever: 'me hacker' })
      expect(response).to be_successful
      expect(cart.user.reload.admin).to eq false
      expect(Order.all.size).to eq 0
    end
  end
end
