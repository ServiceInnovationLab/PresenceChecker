# frozen_string_literal: true

FactoryBot.define do
  factory :visa_type do
    visa_type { ['P', 'A', 'R'].sample }
    description { Faker::Job.title }
  end
end
