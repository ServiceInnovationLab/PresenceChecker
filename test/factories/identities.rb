# frozen_string_literal: true

FactoryBot.define do
  factory :identity do
    client
    identity_number { Faker::IDNumber.spanish_foreign_citizen_number }
    family_name { Faker::Name.last_name }
    first_name { Faker::Name.first_name }
    second_name { Faker::Name.middle_name }
    third_name { Faker::Name.middle_name }
    gender { Faker::Gender.type }
    # date_of_birth { Faker::Date.backward(94) }
    country_of_birth { Country.find_or_create_by(name: Faker::Address.country) }
    nationality { Faker::Nation.nationality }
    issuing_state { Country.find_or_create_by(name: Faker::Address.country) }
    serial_number { Faker::IDNumber.spanish_foreign_citizen_number }
  end
end
