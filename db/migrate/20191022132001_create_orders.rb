class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :name
      t.text :address
      t.string :email
      t.string :phone
      t.integer :status_id, default: 1
      t.references :payment, foreign_key: true

      t.timestamps
    end
    add_index :orders, :status_id
  end
end
