class CreateEligibilities < ActiveRecord::Migration[5.2]
  def change
    create_table :eligibilities do |t|
      t.references :client, null: false
      t.date :day, null: false
      t.json :calculation_data, null: false
      t.boolean :minimum_presence, null: false
      t.boolean :each_year_presence, null: false
      t.boolean :five_year_presence, null: false
      t.json :present_days_by_rolling_year, null: false
      t.json :mimimum_presence_by_rolling_year, null: false
      t.timestamps
    end
    add_foreign_key :eligibilities, :clients
    add_index :eligibilities, [:client_id, :day], unique: true
  end
end
