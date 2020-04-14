class TourReview < ApplicationRecord
  belongs_to :tour
  belongs_to :user

  validates_presence_of :review_text
  validates_numericality_of :rating

end
