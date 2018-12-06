# frozen_string_literal: true

['brenda.wallace', 'dana.iti'].each do |name|
  email = "#{name}@dia.govt.nz"
  User.invite!(email: email) unless User.find_by(email: email)
end

5.times do
  client = FactoryBot.create :client
  FactoryBot.create_list :identity, 3, client: client
end
