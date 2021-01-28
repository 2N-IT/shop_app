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
      select 'Afghanistan', from: 'order[country]'
      find('#order_province').set('Chi')
      find('#order_zip_code').set('15-123')
      select 'cash', from: 'order_payment_method'
      select 'ups', from: 'order_delivery_method'
      click_button 'Submit'
      expect(page).not_to have_content 'Please fill in your delivery and personal data'
      expect(page).to have_content 'George'
      expect(page).to have_content 'Hometown'
      expect(page).to have_content 'Groove'
      expect(page).to have_content 'Afghanistan'
      expect(page).to have_content 'Chi'
      expect(page).to have_content '15-123'
    end

    context 'with errors in the form' do
      it 'renders the form back with errors' do
        click_link 'Checkout'
        find('#order_country').set('Not a Country')
        find('#order_zip_code').set('not a zip code, no way')
        click_button 'Submit'
        expect(page).to have_content 'Please fill in your delivery and personal data'
        expect(page).to have_content('Zip code must be a zip_code/postal code')
        expect(page).to have_content('Zip code must be a zip_code/postal code')
        expect(page).to have_content("Name can't be blank")
        expect(page).to have_content("City can't be blank")
        expect(page).to have_content("Street can't be blank")
        expect(page).to have_content("Province can't be blank")
      end
    end

    context 'with order ready' do
      let!(:cart) { create(:cart, user: user) }
      let(:product) { create :product, quantity: 11, price: 22.22 }
      let(:product_item) { create :product_item, cart: cart, order: order, product: product, quantity: 10 }
      let(:order) { create :order, user: cart.user }

      it 'allows to confirm the order, blocking the Product quantity' do
        visit order_path(order.id)
        expect(page).to have_content order.name
        expect { click_button('Confirm') }.to change { order.reload.status }.from('placed').to('confirmed')
          .and change { product.reload.quantity }.by(product_item.quantity * -1)
          .and change{ cart.product_items.size }.from(1).to(0)
      end
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
      expect(page).not_to have_content 'Checkout'
    end
  end
end
