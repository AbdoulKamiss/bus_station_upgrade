FactoryBot.define do
  factory :booking do
    association :user
    association :travel
    seat_number { "A1" }
    # Ajoute d'autres attributs si nécessaire
  end
end
