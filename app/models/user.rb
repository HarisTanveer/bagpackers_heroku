# Copyright (c) 2015, @sudharti(Sudharsanan Muralidharan)
# Socify is an Open source Social network written in Ruby on Rails This file is licensed
# under GNU GPL v2 or later. See the LICENSE.
require './lib/recommendation.rb'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  acts_as_voter
  acts_as_follower
  acts_as_followable
  acts_as_token_authenticatable


  has_many :posts
  has_many :comments
  has_many :events
  has_many :custom_requests
  has_many :bookings
  has_many :tours, through: :bookings
  has_many :tour_reviews
  has_many :hotel_reviews
  has_many :share_a_locations
  has_one :trip_organizer
  has_one :hotel_manager , foreign_key: 'user_id'

  has_one_attached :profile_picture
  has_one_attached :cover

  validates_presence_of :name
  validates :email , format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
                                      message: "Not a valid Email" }
  validates_presence_of :encrypted_password


  self.per_page = 10

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  include Recommendation

end
