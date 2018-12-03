class AddFirstNameToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :first_name, :string
  end
end
