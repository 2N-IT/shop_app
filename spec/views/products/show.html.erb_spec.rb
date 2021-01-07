require 'rails_helper'

RSpec.describe "products/show", type: :view do
  before(:each) do
    @product = assign(:product, Product.create!({ name: 'Sneakers', price: 49.99, quantity: 4 }))
  end

  it "renders attributes in <p>" do
    render
  end
end
