# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) { create :cart }

  describe 'when items are added' do
    let!(:product_item1) { create :product_item, price: 10, quantity: 2, cart: cart  }
    let!(:product_item2) { create :product_item, price: 5, quantity: 10, cart: cart  }

    it 'can calculate total price for itself' do
      expect(cart.total).to eq "70.00"
      product_item1.update(quantity: 1)
      product_item2.update(price: 1)
      expect(cart.reload.total).to eq "20.00"
    end
  end

  describe 'when items are not added' do
    it 'total will return 0.00' do
      expect(cart.total).to eq "0.00"
    end
  end
end
