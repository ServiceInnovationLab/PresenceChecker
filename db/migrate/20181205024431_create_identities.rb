class CreateIdentities < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.text :name, unique: true, null: false
      t.timestamps
    end
    create_table :identities do |t|
      t.references :client
      t.text :identity_number, null: false
      t.text :family_name
      t.text :first_name
      t.text :second_name
      t.text :third_name
      t.text :gender
      t.references :country_of_birth, index: true, foreign_key: {to_table: :countries}
      t.text :nationality
      t.references :issuing_state, index: true, foreign_key: {to_table: :countries}
      t.text :serial_number, null: false
      t.timestamps
    end

    # the serial number is unique for that country
    add_index :identities, [:issuing_state_id, :serial_number], unique: true
  end
end
