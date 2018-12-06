class RenameMovementMovement < ActiveRecord::Migration[5.2]
  def change
    rename_column :movements, :movement, :direction
  end
end
