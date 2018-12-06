# frozen_string_literal: true

FactoryBot.define do
  factory :identity do
    first_name { 'MyString' }
    last_name { 'MyString' }
    second_name { 'MyString' }
    third_name { 'MyString' }
    date_of_birth { '2018-12-03' }
    country_of_birth { 'MyString' }
    identity { 'MyString' }
  end
end
