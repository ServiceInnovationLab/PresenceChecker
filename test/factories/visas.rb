# frozen_string_literal: true

FactoryBot.define do
  factory :visa do
    start_date { Time.zone.today - 3.years }
    expiry_date { Time.zone.today + 2.years }
    # value Permit has never been observed in real data
    visa_or_permit { ['Visa', 'Permit'].sample }
    single_or_multiple { ['S', 'M'].sample }
    identity
    visa_type
  end
end
