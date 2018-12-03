class AddCountryOfBirthToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :country_of_birth, :string
  end
end
