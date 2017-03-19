class CreateCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :carts do |t|
      t.string :session_id, index: true
      t.boolean :checked_out, default: false
      t.timestamps
    end

    add_index :carts, [:session_id, :checked_out]
  end
end
