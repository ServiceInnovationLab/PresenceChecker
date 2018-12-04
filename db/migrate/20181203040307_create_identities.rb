class CreateIdentities < ActiveRecord::Migration[5.2]
  def change
    create_table :identities do |t|
      t.string :first_name
      t.string :last_name
      t.string :second_name
      t.string :third_name
      t.date :date_of_birth
      t.string :country_of_birth
      t.integer :client_id

      t.timestamps
    end
  end
end
