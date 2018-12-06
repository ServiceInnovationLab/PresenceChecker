# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    im_client_id { Faker::Number.leading_zero_number(10) }
    file_number { Faker::Number.leading_zero_number(10) }
  end
end
