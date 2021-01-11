require 'rails_helper'

RSpec.describe '/admin/products', type: :request do
  let(:valid_attributes) { { name: 'Sneakers', price: 49.99, quantity: 4 } }
  let(:invalid_attributes) { { name: '' } }

  describe 'as an admin' do
    before(:each) do
      admin = User.create(admin: true, email: "email@admin.pl", password: "123blabla345")
      sign_in(admin)
    end
    describe 'GET /index' do
      it 'renders a successful response' do
        Product.create! valid_attributes
        get admin_products_url
        expect(response).to be_successful
      end
    end
    describe 'GET /show' do
      it 'renders a successful response' do
        product = Product.create! valid_attributes
        get admin_product_url(product)
        expect(response).to be_successful
      end
    end

    describe 'GET /new' do
      it 'renders a successful response' do
        get new_admin_product_url
        expect(response).to be_successful
      end
    end

    describe 'GET /edit' do
      it 'render a successful response' do
        product = Product.create! valid_attributes
        get edit_admin_product_url(product)
        expect(response).to be_successful
      end
    end

    describe 'POST /create' do
      context 'with valid parameters' do
        it 'creates a new Product' do
          expect do
            post admin_products_url, params: { product: valid_attributes }
          end.to change(Product, :count).by(1)
        end

        it 'redirects to the created product' do
          post admin_products_url, params: { product: valid_attributes }
          expect(response).to redirect_to(admin_product_url(Product.last))
        end
      end

      context 'with invalid parameters' do
        it 'does not create a new Product' do
          expect do
            post admin_products_url, params: { product: invalid_attributes }
          end.to change(Product, :count).by(0)
        end

        it "renders a successful response (i.e. to display the 'new' template)" do
          post admin_products_url, params: { product: invalid_attributes }
          expect(response).to be_successful
        end
      end
    end

    describe 'PATCH /update' do
      context 'with valid parameters' do
        let(:new_attributes) { { name: 'name', price: 12, quantity: 123 } }

        it 'updates the requested product' do
          product = Product.create! valid_attributes
          patch admin_product_url(product), params: { product: new_attributes }
          product.reload
          expect(
            product.attributes.values_at(:name, :price, :quantity)
          ).to eq(
                 new_attributes.values_at('name', 'price', 'quantity')
               )
        end

        it 'redirects to the product' do
          product = Product.create! valid_attributes
          patch admin_product_url(product), params: { product: new_attributes }
          product.reload
          expect(response).to redirect_to(admin_product_url(product))
        end
      end

      context 'with invalid parameters' do
        it "renders a successful response (i.e. to display the 'edit' template)" do
          product = Product.create! valid_attributes
          patch admin_product_url(product), params: { product: invalid_attributes }
          expect(response).to be_successful
        end
      end
    end

    describe 'DELETE /destroy' do
      it 'destroys the requested product' do
        product = Product.create! valid_attributes
        expect do
          delete admin_product_url(product)
        end.to change(Product, :count).by(-1)
      end

      it 'redirects to the products list' do
        product = Product.create! valid_attributes
        delete admin_product_url(product)
        expect(response).to redirect_to(admin_products_url)
      end
    end
  end

  describe 'as an regular user' do
    context 'GET /index' do
      it 'blocks the /admin endpoints from regular user - redirects' do
        user = User.create(admin: user, email: "user@regular.pl", password: "123blabla345")
        sign_in(user)
        Product.create! valid_attributes
        get admin_products_url
        expect(response.status).to eq 302
      end
    end
  end
end
