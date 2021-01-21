require 'rails_helper'

RSpec.describe '/products', type: :request do
  let(:cart) { create :cart }
  let!(:products) { create_list(:product, 2) }

  before(:each) do
    login_as(cart.user, scope: :user)
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get products_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get product_url(products.sample.id)
      expect(response).to be_successful
    end
  end
end
