class Passenger < ActiveRecord::Base
  has_many :tickets
  has_many :bookings, :through => :tickets
  has_many :flights, :through => :bookings

  validates :name, presence: true
  validates :email, presence: true
end
