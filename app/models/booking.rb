class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :tour
  validates_presence_of :no_of_seats
  validates_numericality_of :user_id
  validates_numericality_of :tour_id
  validates_numericality_of :payment_amount
end
