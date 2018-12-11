# frozen_string_literal: true

['brenda.wallace', 'dana.iti'].each do |name|
  email = "#{name}@dia.govt.nz"
  User.invite!(email: email) unless User.find_by(email: email)
end


# 5.times do
#   client = FactoryBot.create :client
#   4.times do
#     identity = FactoryBot.create(:identity, client: client)
#     FactoryBot.create_list :departure, 10, identity: identity
#     FactoryBot.create_list :arrival, 10, identity: identity
#   end
# end

###########################

# Male
# Lee Jun-fan
# Dual Citizenship

# Identity 1
# Born: California
# Nationality: United States

# Identity 1
# Born: California
# Nationality: Hong Kong

###########################

# Andre Silva
# From Brazil
# Has a visa in Australia

###########################

# Male
# John Blake Smith

###########################





#### Lee Jun-fan ####

Country.create(id: 1, name: "United States of America")
Client.create(id: 1, im_client_id: "12345", file_number: "1")
Identity.create(id: 1, client_id: 1, identity_number: "Y-3183346-E", family_name: "Lee", first_name: "Jun-fan", second_name: "Luella", third_name: "", gender: "Male", country_of_birth_id: 1, nationality: "Samoan", issuing_state_id: 1, serial_number: "Y-3775136-E")



Country.create(id: 1, name: "Samoa")
Client.create(id: 1, im_client_id: "12345", file_number: "1")
Identity.create(id: 1, client_id: 1, identity_number: "Y-3183346-E", family_name: "Laga'aia", first_name: "Pua", second_name: "Luella", third_name: "", gender: "Female", country_of_birth_id: 1, nationality: "Samoan", issuing_state_id: 1, serial_number: "Y-3775136-E")

# Year 1
Movement.create(id: 1, identity_id: 1, direction: "arrival", carrier_date_time: "2014-12-10 20:45:42")
Movement.create(id: 1, identity_id: 1, direction: "departure", carrier_date_time: "2014-22-10 20:45:42")
# Year 2
Movement.create(id: 1, identity_id: 1, direction: "arrival", carrier_date_time: "2015-12-10 20:45:42")
Movement.create(id: 1, identity_id: 1, direction: "departure", carrier_date_time: "2015-22-10 20:45:42")
# Year 3
Movement.create(id: 1, identity_id: 1, direction: "arrival", carrier_date_time: "2016-12-10 20:45:42")
Movement.create(id: 1, identity_id: 1, direction: "departure", carrier_date_time: "2016-22-10 20:45:42")
# Year 4
Movement.create(id: 1, identity_id: 1, direction: "arrival", carrier_date_time: "2017-12-10 20:45:42")
Movement.create(id: 1, identity_id: 1, direction: "departure", carrier_date_time: "2017-22-10 20:45:42")
# Year 5
Movement.create(id: 1, identity_id: 1, direction: "arrival", carrier_date_time: "2018-12-10 20:45:42")
Movement.create(id: 1, identity_id: 1, direction: "departure", carrier_date_time: "2018-22-10 20:45:42")



Country.create(id: 2, name: "United States of America")
Client.create(id: 2, im_client_id: "123456", file_number: "2")

# John Smith
Identity.create(id: 2, client_id: 2, identity_number: "Y-5183346-E", family_name: "Smith", first_name: "John", second_name: "", third_name: "", gender: "Male", country_of_birth_id: 2, nationality: "American", issuing_state_id: 2, serial_number: "Y-5775136-E")

# John Blake Smith
Identity.create(id: 2, client_id: 2, identity_number: "Y-5183347-E", family_name: "Smith", first_name: "John", second_name: "Blake", third_name: "", gender: "Male", country_of_birth_id: 2, nationality: "American", issuing_state_id: 2, serial_number: "Y-5775136-E")
# Year 1
Movement.create(id: 2, identity_id: 2, direction: "in", carrier_date_time: "2014-12-10 20:45:42")
Movement.create(id: 2, identity_id: 2, direction: "out", carrier_date_time: "2014-22-10 20:45:42")
# Year 2
Movement.create(id: 2, identity_id: 2, direction: "in", carrier_date_time: "2015-12-10 20:45:42")
Movement.create(id: 2, identity_id: 2, direction: "out", carrier_date_time: "2015-22-10 20:45:42")
# Year 3
Movement.create(id: 2, identity_id: 2, direction: "in", carrier_date_time: "2016-12-10 20:45:42")
Movement.create(id: 2, identity_id: 2, direction: "out", carrier_date_time: "2016-22-10 20:45:42")
# Year 4
Movement.create(id: 2, identity_id: 2, direction: "in", carrier_date_time: "2017-12-10 20:45:42")
Movement.create(id: 2, identity_id: 2, direction: "out", carrier_date_time: "2017-22-10 20:45:42")
# Year 5
Movement.create(id: 2, identity_id: 2, direction: "in", carrier_date_time: "2018-12-10 20:45:42")
Movement.create(id: 2, identity_id: 2, direction: "out", carrier_date_time: "2018-22-10 20:45:42")

