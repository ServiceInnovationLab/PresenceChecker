class AddClientIdToIdentities < ActiveRecord::Migration[5.2]
  def change
    add_column :identities, :client_id, :integer
  end
end
