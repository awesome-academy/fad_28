class CreateSuggests < ActiveRecord::Migration[5.2]
  def change
    create_table :suggests do |t|
      t.string :your_name
      t.string :product_name
      t.string :image
      t.text :description

      t.timestamps
    end
  end
end
