class CreateMovements < ActiveRecord::Migration[5.2]
  def change
    create_table :movements do |t|
      t.date :arrival_date
      t.date :departure_date
      t.integer :client_id

      t.timestamps
    end
  end
end
