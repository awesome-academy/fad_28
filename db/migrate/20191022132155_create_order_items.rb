class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.integer :quantity, default: 1
      t.float :price
      t.references :product, foreign_key: true
      t.references :order, foreign_key: true

      t.timestamps
    end
    add_index :order_items, :created_at
  end
end
