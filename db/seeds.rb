# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ActiveRecord::Base.transaction do
    Station.destroy_all

    ActiveRecord::Base.connection.reset_pk_sequence!('stations')

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
end