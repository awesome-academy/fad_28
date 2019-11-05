class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :image
      t.float :price
      t.float :discount
      t.date :close_discount_at
      t.boolean :sold_many, default: false
      t.text :description
      t.references :category, foreign_key: true

      t.timestamps
    end
    add_index :products, :created_at
  end
end
