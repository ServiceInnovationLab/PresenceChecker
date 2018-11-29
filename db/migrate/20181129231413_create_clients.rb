class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :identity
      t.string :country
      t.datetime :departures
      t.datetime :arrivals

      t.timestamps
    end
  end
end
