class AddAdminAndSuspendedToUser < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean
    add_column :users, :suspended, :boolean
  end
end
