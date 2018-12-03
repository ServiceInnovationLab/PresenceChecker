class AddGenderToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :gender, :string
  end
end
