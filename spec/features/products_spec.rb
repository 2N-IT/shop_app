# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Products' do
  let(:cart) { create(:cart, :with_items) }
  let(:product_item) { cart.product_items.first }
  before do
    login_as(cart.user, scope: :user)
    visit root_path
    click_link 'Products'
  end

  describe 'with a list of products' do
    it 'user can access a singular product page' do
      find("##{product_item.name}-details").click
      expect(page).to have_content product_item.name
      expect(page).to have_content product_item.price
    end
  end
end
