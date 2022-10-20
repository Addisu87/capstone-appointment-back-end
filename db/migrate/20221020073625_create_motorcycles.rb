class CreateMotorcycles < ActiveRecord::Migration[7.0]
  def change
    create_table :motorcycles do |t|
      t.string :model
      t.integer :duration
      t.integer :price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
