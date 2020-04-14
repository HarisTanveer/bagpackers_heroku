class TripOrganizer < ApplicationRecord
  has_one_attached :license
  belongs_to :user
  has_many :tours
  has_one_attached :company_logo
  has_many :tour_reviews, through: :tours
  has_many :bookings, through: :tours



  validates_uniqueness_of :user_id
  validates_presence_of :company_name
  validates_presence_of :company_number
  validates :company_email , format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
                               message: "Not a valid Email" }
  validates_presence_of :address
  validates_presence_of :about
  validates_presence_of :terms
  validates_presence_of :company_logo
  validates_presence_of :license
  validates_presence_of :cancellation_policy
  validates_presence_of :url

end