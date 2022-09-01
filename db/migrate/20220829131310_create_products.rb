class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.integer :discount
      t.text :description
      t.boolean :active, default: true
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
  end
end
