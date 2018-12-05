class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.text :im_client_id, null: false
      t.text :file_number
      t.timestamps
    end
  end
end
