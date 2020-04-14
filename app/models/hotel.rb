class Hotel < ApplicationRecord
  has_many_attached :hotel_cover_photos
  has_one_attached :proof_of_ownership
  belongs_to :hotel_manager , foreign_key: 'hotel_manager_id'
  has_many :hotel_reviews, foreign_key: 'hotels_id' , :dependent => :delete_all
  has_one :hotel_facility, foreign_key: 'hotels_id' , :dependent => :destroy
  has_many :hotel_rooms , foreign_key: 'hotels_id' , :dependent => :delete_all
  belongs_to :location, foreign_key: "locations_id"

  validates :number, numericality: true
  validates :name, presence: true
  validates :info, presence: true
  validates :address, presence: true
  validates :hotel_cover_photos , presence: true
  validates :email , presence: true

  validates_presence_of :proof_of_ownership

end
