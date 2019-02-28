class CreateVisas < ActiveRecord::Migration[5.2]
  def change
    create_table :visas do |t|
      t.string :visa_or_permit, null: false
      t.string :single_or_multiple, null: false
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
