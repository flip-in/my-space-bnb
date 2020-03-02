class RenameClassFromSpaceships < ActiveRecord::Migration[5.2]
  def change
    rename_column :spaceships, :class, :spaceship_class
  end
end
