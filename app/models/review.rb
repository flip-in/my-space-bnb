class Review < ApplicationRecord
  belongs_to :booking
  belongs_to :user
  validates :content, presence: true;
  validates :stars, presence: true,  inclusion: {in: [0,1,2,3,4,5]}
end
