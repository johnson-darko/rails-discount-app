class CreateStores < ActiveRecord::Migration[7.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.time :opening_hour
      t.time :closing_hour
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
