class CreateVisas < ActiveRecord::Migration[5.2]
  def change
    create_table :visas do |t|
      t.date :start_date, null: false
      t.date :expiry_date, null: true
      t.references :visa_type, null: false
      t.references :identity, null: false

      t.timestamps
    end

    add_foreign_key :visas, :visa_types
    add_foreign_key :visas, :identities
  end
end
