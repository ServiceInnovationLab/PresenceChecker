# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: [:owner] do
    email { Faker::Internet.email }
    password { "#{Faker::Internet.password}P@ssw0rd}" }
    # after(:create) do |user, _evaluator|
    #   user.confirm
    # end
  end
end
