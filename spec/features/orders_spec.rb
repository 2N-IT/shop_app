# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Orders' do
  let(:user) { create :user }
  describe 'with products in a cart' do
    let!(:cart) { create(:cart, :with_items, user: user) }
    before do
      login_as(user, scope: :user)
      visit root_path
      click_link 'Cart'
    end

    it 'user can proceed to checkout' do
      expect(page).to have_content cart.product_items[0].name
      expect(page).to have_content cart.product_items[1].name
      expect(page).to have_content "Total: #{cart.total}" # cart should have a method that calculates its price
      click_link 'Checkout'
      expect(page).to have_content 'Please fill in your delivery and personal data'
      expect(page).to have_content 'Payment Method'
    end

    it 'user can fill out his data in the checkout' do
      click_link 'Checkout'
      find('#order_name').set('George')
      find('#order_city').set('Hometown')
      find('#order_street').set('Groove')
      find('#order_country').set('Boston')
      find('#order_province').set('Chi')
      find('#order_zip_code').set('15-123')
      select 'cash', from: 'order_payment_method'
      select 'ups', from: 'order_delivery_method'
      click_button 'Submit'
      expect(page).not_to have_content 'Please fill in your delivery and personal data'
      expect(page).to have_content 'George'
      expect(page).to have_content 'Hometown'
      expect(page).to have_content 'Groove'
      expect(page).to have_content 'Boston'
      expect(page).to have_content 'Chi'
      expect(page).to have_content '15-123'
    end
  end

  describe 'with no products in cart' do
    let!(:cart) { create(:cart, user: user) }
    before do
      login_as(user, scope: :user)
      visit root_path
      click_link 'Cart'
    end

    it 'user can not proceed to checkout' do
      click_link 'Checkout'
      expect(page).not_to have_content 'Please fill in your delivery and personal data'
      expect(page).not_to have_content 'Payment method:'
    end
  end
end
