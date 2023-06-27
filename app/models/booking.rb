class Booking < ApplicationRecord
    belongs_to :travel 
    has_many :user_bookings, dependent: :destroy
    has_many :users, through: :user_bookings, inverse_of: :bookings
end
