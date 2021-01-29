# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Products' do
  describe 'with a list of products' do
    let(:cart) { create(:cart, :with_items) }
    let(:product_item) { cart.product_items.first }
    before do
      login_as(cart.user, scope: :user)
      visit root_path
      click_link 'Products'
    end

    it 'user can access a singular product page' do
      find("##{product_item.name}-details").click
      expect(page).to have_content product_item.name
      expect(page).to have_content product_item.price
    end
  end

  describe 'with details view' do
    let(:cart) { create(:cart) }
    let(:product) { create :product, quantity: 15 }
    before do
      login_as(cart.user, scope: :user)
      visit product_path(product.id)
    end

    # You can test the modal too!
    it 'can add stuff to cart' do
      expect(cart.reload.product_items.size).to eq 0
      find('.modal-control').click
      expect(page).to have_content "Add #{product.name} to cart"
      find("#cart_quantity#{product.id}").set(5)
      click_button 'Add'
      expect(cart.reload.product_items.size).to eq 1
      expect(cart.product_items.first.quantity).to eq 5
    end
  end
end
