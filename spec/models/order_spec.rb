# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'with normal data' do
    let(:order) { build(:order, country: COUNTRIES.sample, zip_code: '12-123') }

    it 'saves' do
      expect(order.save!).to eq true
      expect(Order.all.size).to eq 1
    end
  end

  context 'with invalid data' do
    let(:order) do
      build(:order,
            name: '',
            city: '',
            province: '',
            street: '',
            payment_method: 'none',
            delivery_method: 'birds',
            zip_code: 'not_a_zip_code',
            country: 'Malazan Empire')
    end
    it 'validates and throws an error' do
      expect(order.save).to eq false
      expect(order.errors.size).to eq 8
      expect(order.errors.full_messages).to eq(
        [
          'Country Malazan Empire is not a valid size',
          'Zip code must be a zip_code/postal code',
          "Name can't be blank",
          "City can't be blank",
          "Street can't be blank",
          "Province can't be blank",
          'Payment method is not included in the list',
          'Delivery method is not included in the list'
        ]
      )
    end
  end
end
