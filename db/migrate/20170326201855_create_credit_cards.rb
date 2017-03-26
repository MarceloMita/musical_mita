class CreateCreditCards < ActiveRecord::Migration[5.0]
  def change
    create_table :credit_cards do |t|
      t.references :client
      t.string :expiration_month
      t.string :expiration_year
      t.string :number
      t.string :cvc
      t.string :holder_name
      t.date :holder_birthdate
      t.string :holder_cpf

      t.timestamps
    end
  end
end
