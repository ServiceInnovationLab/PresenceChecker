class RemoveFieldIdentityFromClients < ActiveRecord::Migration[5.2]
  def change
    remove_column :clients, :identity, :string
  end
end
