class CreateCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :carts do |t|
      t.string :session_id, index: true
      t.timestamps
    end
  end
end
