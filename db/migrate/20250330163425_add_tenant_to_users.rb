class AddTenantToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :tenant, :string
    remove_index :users, :email_address
    add_index(:users, [ :email_address, :tenant ], unique: true)
  end
end
