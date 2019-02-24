# frozen_string_literal: true

FactoryBot.define do
  factory :visa_type do
    name { Faker::Job.title }
    indefinite { [true, false].sample }
  end
end
