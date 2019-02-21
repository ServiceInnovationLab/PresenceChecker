class CreateVisaTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :visa_types do |t|
      t.string :name, null: false
      t.boolean :indefinite, null: false

      t.timestamps
    end
  end
end
