class AddStatusAndPriceToSpaceships < ActiveRecord::Migration[5.2]
  def change
    add_column :spaceships, :price, :integer
    add_column :spaceships, :rating, :integer
  end
end
