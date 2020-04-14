class HotelReview < ApplicationRecord
  belongs_to :user
  belongs_to :hotel , foreign_key: 'hotels_id'

  validates_presence_of :review_text
  validates_numericality_of :rating
end
