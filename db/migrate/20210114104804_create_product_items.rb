class CreateProductItems < ActiveRecord::Migration[6.1]
  def change
    create_table :product_items do |t|
      t.string :name
      t.decimal :price
      t.integer :quantity
      t.references :product, index: true, foreign_key: true
      t.references :cart, index: true
      t.timestamps
    end
  end
end
