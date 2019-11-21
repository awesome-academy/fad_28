class CreateSuggests < ActiveRecord::Migration[5.2]
  def change
    create_table :suggests do |t|
      t.string :product_name
      t.string :image
      t.text :description
      t.boolean :admin_seen

      t.timestamps
    end
  end
end
