class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :title
      t.string :cached_slug, index: true
      t.text :description
      t.string :image_name
      t.float :value

      t.timestamps
    end
  end
end
