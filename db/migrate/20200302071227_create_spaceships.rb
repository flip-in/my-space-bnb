class CreateSpaceships < ActiveRecord::Migration[5.2]
  def change
    create_table :spaceships do |t|
      t.string :name
      t.string :passengers
      t.string :length
      t.string :speed
      t.string :class
      t.string :crew
      t.string :location
      t.string :manufacturer
      t.string :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
