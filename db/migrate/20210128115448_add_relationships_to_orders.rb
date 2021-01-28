class AddRelationshipsToOrders < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :user, index: true
    add_reference :product_items, :order, index: true
  end
end
