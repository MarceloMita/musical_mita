class CreateCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :carts do |t|
      t.references :client, index: true
      t.string :session_id, index: true
      t.integer :status, default: 0
      t.string :moip_order_id
      t.string :moip_payment_id
      t.string :cupon
      t.timestamps
    end

    add_index :carts, [:session_id, :status]
  end
end
