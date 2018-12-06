class CreateMovements < ActiveRecord::Migration[5.2]
  def change
    create_table :movements do |t|
      t.references :identity, null: false
      t.text :movement, null: false
      t.datetime :carrier_date_time, null: false
      t.timestamps
    end
  end
end
