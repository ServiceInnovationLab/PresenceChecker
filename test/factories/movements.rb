# frozen_string_literal: true

FactoryBot.define do
  factory :movement do
    arrival_date { '2018-12-04' }
    departure_date { '2018-12-04' }
    client_id { 'MyString' }
  end
end
