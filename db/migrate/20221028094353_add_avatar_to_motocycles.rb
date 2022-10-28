class AddAvatarToMotocycles < ActiveRecord::Migration[7.0]
  def change
    add_column :motorcycles, :avatar, :string
  end
end
