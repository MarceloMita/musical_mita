class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :title
      t.string :cached_slug
      t.text :description
      t.float :value

      t.timestamps
    end
  end
end
