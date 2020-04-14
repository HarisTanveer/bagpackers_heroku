class Location < ApplicationRecord
  has_many_attached :images
  has_and_belongs_to_many :locations
  has_many :tours, foreign_key: "locations_id"
  has_many :hotels, foreign_key: "locations_id"
  has_many :tourism_types

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :images
end