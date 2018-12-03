class AddSecondNameToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :second_name, :string
  end
end
