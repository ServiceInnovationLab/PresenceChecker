# frozen_string_literal: true

FactoryBot.define do
  factory :movement do
    identity { FactoryBot.create :identity }
    direction { '' }
    carrier_date_time { Faker::Date.backward(3650) }
    visa_type { '' }
  end
  factory :departure, parent: :movement do
    direction { 'departure' }
    # visa_type is always nil when departing.
    visa_type { nil }
  end
  factory :arrival, parent: :movement do
    direction { 'arrival' }
    # A visa_type will be picked at random from the eligible visas.
    visa_type { ['P', 'A', 'R'].sample }
  end
end
