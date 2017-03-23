class CreatePhones < ActiveRecord::Migration[5.0]
  def change
    create_table :phones do |t|
      t.references :user, polymorphic: true, index: true

      t.string :country_code
      t.string :area_code
      t.string :number

      t.timestamps
    end
  end
end
