FactoryBot.define do
  factory :user do
    name { 'John' }
    email { 'john@gmail.com' }
    password { '123456' }
    password_confirmation { '123456' }
    admin { false }
  end
end
