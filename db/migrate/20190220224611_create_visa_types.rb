class CreateVisaTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :visa_types do |t|
      t.string :visa_type, null: false
      t.string :description, null: false

      t.timestamps
    end
  end
end
