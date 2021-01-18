require 'rails_helper'

RSpec.describe "products/show", type: :view do
  before(:each) do
    @product = assign(:product, Product.create!({ name: 'Sneakers', price: 49.99, quantity: 4 }))
  end

  it 'allows to add to cart' do
    render
    expect(rendered).to match(/shopping-cart/)
  end

end
