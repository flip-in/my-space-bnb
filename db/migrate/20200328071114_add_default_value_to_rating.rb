class AddDefaultValueToRating < ActiveRecord::Migration[5.2]
  def change
    change_column :spaceships, :rating, :integer, default: 0
  end
end