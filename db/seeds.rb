# frozen_string_literal: true

require 'faker'
include Faker

5.times do
  client = FactoryBot.create :client
  4.times do
    identity = FactoryBot.create(:identity, client: client)
    FactoryBot.create_list :departure, 10, identity: identity
    # FactoryBot.create_list :arrival, 10, identity: identity
  end
end
