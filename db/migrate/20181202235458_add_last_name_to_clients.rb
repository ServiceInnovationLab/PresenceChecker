class AddLastNameToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :last_name, :string
  end
end
