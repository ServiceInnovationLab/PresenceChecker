class AddThirdNameToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :third_name, :string
  end
end
