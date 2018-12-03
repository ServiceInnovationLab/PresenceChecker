class AddIdentityIdToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :identity_id, :integer
  end
end
