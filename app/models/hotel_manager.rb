class HotelManager < ApplicationRecord
  belongs_to :user , foreign_key: 'user_id'
  has_many :hotels , foreign_key: 'hotel_manager_id'
  has_one_attached :company_logo
  has_many :hotel_reviews, through: :hotels

  validates_uniqueness_of :user_id
  validates_presence_of :company_name
  validates_presence_of :company_logo

end
