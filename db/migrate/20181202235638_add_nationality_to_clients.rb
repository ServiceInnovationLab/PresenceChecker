class AddNationalityToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :nationality, :string
  end
end
