require 'rails_helper'

RSpec.describe "products/index", type: :view do
  before(:each) do
    assign(:products, [
      Product.create!({ name: 'Sneakers', price: 49.99, quantity: 4 }),
      Product.create!({ name: 'Shirt', price: 4.99, quantity: 40 })
    ])
  end

  it "renders a list of products" do
    render

    expect(rendered).to match /Sneakers/
    expect(rendered).to match /Shirt/
  end
end
