class AddPassportNoToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :passport_no, :string
  end
end
''
