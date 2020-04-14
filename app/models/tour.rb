class Tour < ApplicationRecord
  include SimpleRecommender::Recommendable
  belongs_to :trip_organizer
  has_many :tour_details,  dependent: :delete_all
  has_many :tour_reviews, dependent: :delete_all
  has_many :bookings, dependent: :restrict_with_error
  has_one_attached :image, dependent: :delete
  has_many_attached :trip_images, dependent: :delete_all

  has_many :users, through: :bookings
  similar_by :users

  belongs_to :tourism_type, foreign_key: "tourims_type_id"
  belongs_to :location, foreign_key: "locations_id"

  validates :seats, numericality: true
  validates :duration, numericality: true
  validates :price, numericality: true
  validates :title, presence: true
  validates :date , presence: true
  validates :image, presence:true

  validates :tourims_type_id, presence: true
  validates :locations_id, presence: true
end
