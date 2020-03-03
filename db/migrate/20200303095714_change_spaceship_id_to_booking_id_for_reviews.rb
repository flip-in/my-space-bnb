class ChangeSpaceshipIdToBookingIdForReviews < ActiveRecord::Migration[5.2]
  def change
    remove_reference :reviews, :spaceship
    add_reference :reviews, :booking, foreign_key: true
  end
end
