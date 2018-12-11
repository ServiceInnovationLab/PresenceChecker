# frozen_string_literal: true

FactoryBot.define do
  factory :movement do
    identity { FactoryBot.create :identity }
    direction { '' }
    carrier_date_time { Faker::Date.backward(3650) }
  end
  factory :departure, parent: :movement do
    direction { 'departure' }
  end
  factory :arrival, parent: :movement do
    direction { 'arrival' }
  end
end
