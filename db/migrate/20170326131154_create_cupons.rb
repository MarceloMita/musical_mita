class CreateCupons < ActiveRecord::Migration[5.0]
  def change
    create_table :cupons do |t|
      t.string :code
      t.datetime :expires_at

      t.timestamps
    end
  end
end
