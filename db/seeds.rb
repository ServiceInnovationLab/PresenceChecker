# frozen_string_literal: true

['brenda.wallace', 'dana.iti'].each do |name|
  email = "#{name}@dia.govt.nz"
  User.invite!(email: email) unless User.find_by(email: email)
end

5.times do
  client = FactoryBot.create :client
  4.times do
    identity = FactoryBot.create(:identity, client: client)
    FactoryBot.create_list :departure, 10, identity: identity
    FactoryBot.create_list :arrival, 10, identity: identity
  end
end
