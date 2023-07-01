# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
DURATIONS = {
    'KYS' => {
        'KLK' => 720,
        'SKS' => 960,
        'SGO' => 840,
        'MPI' => 1200,
        'TBT' => 1620,
        'GAO' => 1380,
        'KDL' => 2280,
        'MNK' => 1260,
        'BKO' => 660
    },
    'KLK' => {
        'SKS' => 420,
        'SGO' => 180,
        'MPI' => 540,
        'TBT' => 930,
        'GAO' => 760,
        'KDL' => 1620,
        'MNK' => 1280,
        'BKO' => 45
    },
    'SKS' => {
        'SGO' => 290,
        'MPI' => 540,
        'TBT' => 840,
        'GAO' => 860,
        'KDL' => 1500,
        'MNK' => 1200,
        'BKO' => 360
    },
    'SGO' => {
        'MPI' => 360,
        'TBT' => 780,
        'GAO' => 960,
        'KDL' => 1440,
        'MNK' => 1140,
        'BKO' => 210
    },
    'MPI' => {
        'TBT' => 440,
        'GAO' => 540,
        'KDL' => 1080,
        'MNK' => 780,
        'BKO' => 540
    },
    'TBT' => {
        'GAO' => 600,
        'KDL' => 1200,
        'MNK' => 860,
        'BKO' => 960
    },
    'GAO' => {
        'KDL' => 590,
        'MNK' => 270,
        'BKO' => 1020
    },
    'KDL' => {
        'MNK' => 840,
        'BKO' => 1620
    },
    'MNK' => {
        'BKO' => 1320
    },
    'BKO' => {}
}

def get_duration(starting_station, destination_station)
    DURATIONS[starting_station][destination_station] || DURATIONS[destination_station][starting_station]
end

def random_time
    hours = Faker::Number.between(from: 0, to: 23)
    minutes = [0, 15, 30, 45].sample
  
    time_string = "#{format('%02d', hours)}:#{format('%02d', minutes)}"
    Time.strptime(time_string, '%H:%M')
end

ActiveRecord::Base.transaction do
    Booking.destroy_all
    Station.destroy_all
    Travel.destroy_all

    ActiveRecord::Base.connection.reset_pk_sequence!('bookings')
    ActiveRecord::Base.connection.reset_pk_sequence!('stations')
    ActiveRecord::Base.connection.reset_pk_sequence!('travels')

    stations = []
    stations[0] = Station.create(code: 'KYS', name: 'Kayes Station', city: 'Kayes')
    stations[1] = Station.create(code: 'KLK', name: 'Koulikoro Station', city: 'Koulikoro')
    stations[2] = Station.create(code: 'SKS', name: 'Sikasso Station', city: 'Sikasso')
    stations[3] = Station.create(code: 'SGO', name: 'Segou Station', city: 'Segou')
    stations[4] = Station.create(code: 'MPI', name: 'Mopti Station', city: 'Mopti')
    stations[5] = Station.create(code: 'TBT', name: 'Tombouctou Station', city: 'Tombouctou')
    stations[6] = Station.create(code: 'GAO', name: 'Gao Station', city: 'Gao')
    stations[7] = Station.create(code: 'KDL', name: 'Kidal Station', city: 'Kidal')
    stations[8] = Station.create(code: 'MNK', name: 'Menaka Station', city: 'Menaka')
    stations[9] = Station.create(code: 'BKO', name: 'Bamako Station', city: 'Bamako')

    Date.new(2023, 7, 1).upto(Date.new(2023, 7, 15)).each do |date|
        stations.each do |starting_station|
          stations.each do |destination_station|
            next if starting_station == destination_station
    
            3.times { Travel.create(date: date,
                                    time: random_time,
                                    starting_station: starting_station,
                                    destination_station: destination_station,
                                    duration: get_duration(starting_station.code, destination_station.code))
                      }
            end
        end
    end
end