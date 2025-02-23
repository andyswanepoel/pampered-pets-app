class AddAccountVerifiedToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :account_verified, :boolean, default: false
  end
end
