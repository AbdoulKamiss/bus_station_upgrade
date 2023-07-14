FactoryBot.define do
  factory :station1, class: Station do
    code { 'KYS' }
    name { 'Kayes Station' }
    city { 'Kayes' }
    latitude { '12.0655' }
    longitude { '-10.88' }
  end
  factory :station2, class: Station do
    code { 'KLK' }
    name { 'Koulikoro Station' }
    city { 'Koulikoro' }
    latitude { '14.666' }
    longitude { '-6.4555' }
  end
end
