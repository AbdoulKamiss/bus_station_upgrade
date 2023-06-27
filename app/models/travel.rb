class Travel < ApplicationRecord
    belongs_to :starting_station, class_name: :Station
    belongs_to :destination_station, class_name: :Station
    has_many :bookings
    has_many :users, through: :bookings

    validates :starting_station, presence: true
    validates :destination_station, presence: true
    validates :date, presence: true
    validates :time, presence: true
    validates :duration, presence: true

end
