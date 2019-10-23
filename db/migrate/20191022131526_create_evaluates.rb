class CreateEvaluates < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluates do |t|
      t.integer :star, default: 5
      t.text :content
      t.references :product, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :evaluates, :created_at
  end
end
