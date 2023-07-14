FactoryBot.define do
  factory :travel do
    date { '2023-07-15' }
    time { '09:00:00' }
    duration { '120' }
    association :starting_station, factory: :station1
    association :destination_station, factory: :station2
  end
end
