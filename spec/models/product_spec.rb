# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'when data provided is valid' do
    let(:params) { { name: 'Sneakers', price: 49.99, quantity: 4 } }

    it 'saves the instance' do
      expect(described_class.new(params).save!).to eq true
    end

    it { expect { described_class.new(params).save! }.to change { Product.all.size }.by(1) }
  end

  context 'when data provided is invalid' do
    context 'when name is missing' do
      let(:params) { { name: '', price: 12.12, quantity: 1 } }

      it 'throws an explicit error' do
        expect { described_class.create!(params) }.to raise_error("Validation failed: Name can't be blank")
      end
    end

    context 'when price is missing' do
      let(:params) { { name: 'product', price: nil, quantity: 1 } }

      it 'throws an explicit error' do
        expect { described_class.create!(params) }.to raise_error("Validation failed: Price can't be blank")
      end
    end

    context 'when quantity is missing' do
      let(:params) { { name: 'product', price: 12.12, quantity: nil } }

      it 'throws an explicit error' do
        expect { described_class.create!(params) }.to raise_error("Validation failed: Quantity can't be blank")
      end
    end
  end
end
