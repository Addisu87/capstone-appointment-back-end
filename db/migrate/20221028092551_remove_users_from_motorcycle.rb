class RemoveUsersFromMotorcycle < ActiveRecord::Migration[7.0]
  def change
    remove_column :motorcycles, :user_id
  end
end
