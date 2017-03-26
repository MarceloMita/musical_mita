class CreateMoipWebhooks < ActiveRecord::Migration[5.0]
  def change
    create_table :moip_webhooks do |t|
      t.string :events
      t.string :target
      t.string :token
      t.string :moip_id

      t.timestamps
    end
  end
end
