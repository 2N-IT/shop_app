require 'rails_helper'

RSpec.describe "products/new", type: :view do
  before(:each) do
    assign(:product, Product.new())
  end

  it "renders new product form" do
    render

    expect(rendered).to match /products/
    expect(rendered).to match /submit/
    expect(rendered).to match /name/
    expect(rendered).to match /quantity/
    expect(rendered).to match /price/
  end
end
