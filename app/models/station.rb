class Station < ApplicationRecord
    has_many :departing_travels, class_name: :Travel, foreign_key: :starting_station_id, dependent: :destroy
    has_many :arriving_travels, class_name: :Travel, foreign_key: :destination_station_id, dependent: :destroy
end
