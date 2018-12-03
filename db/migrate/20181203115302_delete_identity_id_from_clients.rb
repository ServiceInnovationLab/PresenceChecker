class DeleteIdentityIdFromClients < ActiveRecord::Migration[5.2]
  def change
    remove_column :clients, :identity_id
    remove_column :identities, :identity
  end
end
