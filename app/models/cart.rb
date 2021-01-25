class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :product_items

  def total
    format('%.2f', product_items.map{ |item| item.quantity * item.price }.sum.round(2))
  end
end
