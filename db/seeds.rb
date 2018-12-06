# frozen_string_literal: true

require 'faker'
include Faker

5.times do
  Client.create(
    passport_no: Bank.iban('be')
  )
end

5.times do |i|
  Identity.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    second_name: Faker::Name.middle_name,
    third_name: '',
    date_of_birth: '2001-09-10',
    country_of_birth: Faker::Address.country,
    client_id: i + 1
  )
end

5.times do |i|
  Movement.create(
    arrival_date: 8.days.ago,
    departure_date: 1.day.ago,
    client_id: i
  )
end
