class RemoveUniquenessOnIdentityIndex < ActiveRecord::Migration[5.2]
  def up
    # remove uniqueness constraint - our real world data doesn't respect it
    remove_index :identities, [:issuing_state_id, :serial_number]
    add_index :identities, [:issuing_state_id, :serial_number]
  end

  def down
    remove_index :identities, [:issuing_state_id, :serial_number]
    add_index :identities, [:issuing_state_id, :serial_number], unique: true
  end
end
