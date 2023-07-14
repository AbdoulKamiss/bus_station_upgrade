class Travel < ApplicationRecord
    belongs_to :starting_station, class_name: :Station
    belongs_to :destination_station, class_name: :Station
    has_many :bookings, dependent: :destroy
    has_many :users, through: :bookings

    validates :starting_station, presence: true
    validates :destination_station, presence: true
    validates :date, presence: true
    validates :time, presence: true
    validates :duration, presence: true
    validate :validate_booking_limit
    validate :different_starting_and_destination_stations

    def formatted_date
        date.strftime("%m/%d/%Y")
    end
    
    def formatted_time
        time.strftime('%H:%M')
    end

    def formatted_duration
        "%dh %02dm" % duration.divmod(60)
    end

    def boarding_time
        (time - 1800).strftime('%H:%M')
    end

    private

    def validate_booking_limit
        if bookings.count >= 8
            errors.add(:base, "Le voyage est complet. Aucune réservation supplémentaire n'est autorisée.")
        end
    end
    
    def different_starting_and_destination_stations
        if starting_station_id == destination_station_id
          errors.add(:base, "Starting station and destination station must be different")
        end
    end
end
