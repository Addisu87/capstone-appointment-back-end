class CreateMotorcycles < ActiveRecord::Migration[7.0]
  def change
    create_table :motorcycles do |t|
      t.string :model
      t.integer :duration
      t.text :description
      t.integer :price
      t.references :user, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
