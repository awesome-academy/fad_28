class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :remember_digest
      t.string :name
      t.text :address
      t.string :email
      t.string :phone
      t.integer :status_id, default: 1
      t.integer :payment_id, default: 1

      t.timestamps
    end
    add_index :orders, :status_id
  end
end
