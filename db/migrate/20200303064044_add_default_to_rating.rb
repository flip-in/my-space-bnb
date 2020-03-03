class AddDefaultToRating < ActiveRecord::Migration[5.2]
  def change
    change_column :reviews, :stars, :integer, default: 0
  end
end
