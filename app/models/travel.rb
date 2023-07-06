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
    before_save :validate_booking_limit

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
end
