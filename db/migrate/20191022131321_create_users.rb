class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer :role_id, default: 2
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.string :name
      t.boolean :gender
      t.text :address
      t.string :phone
      t.string :image

      t.timestamps
    end
    add_index :users, :role_id
    add_index :users, :email, unique: true
  end
end
