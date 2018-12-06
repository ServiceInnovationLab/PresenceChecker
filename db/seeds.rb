# frozen_string_literal: true

require 'faker'
include Faker

5.times do
  client = FactoryBot.create :client
  FactoryBot.create_list :identity, 3, client: client
end
