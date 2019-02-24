# frozen_string_literal: true

FactoryBot.define do
  factory :visa do
    start_date { Time.zone.today - 3.years }
    expiry_date { Time.zone.today + 2.years }
    identity
    visa_type
  end
end
