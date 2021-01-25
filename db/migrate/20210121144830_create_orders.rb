class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :city
      t.string :street
      t.string :country
      t.string :province
      t.string :zip_code
      t.string :payment_method
      t.string :delivery_method
      t.string :status, null: false, default: 'placed'
      t.timestamps
    end
  end
end
