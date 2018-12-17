# frozen_string_literal: true

['brenda.wallace', 'dana.iti'].each do |name|
  email = "#{name}@dia.govt.nz"
  User.invite!(email: email) unless User.find_by(email: email)
end

# 5.times do
#   client = FactoryBot.find_or_create_by :client
#   4.times do
#     identity = FactoryBot.find_or_create_by(:identity, client: client)
#     FactoryBot.find_or_create_by_list :departure, 10, identity: identity
#     FactoryBot.find_or_create_by_list :arrival, 10, identity: identity
#   end
# end

###########################

# Male
# Lee Jun-fan (Bruce Lee)
# Dual Citizenship

# Identity 1
# Born: California
# Nationality: United States

# Identity 2
# Born: California
# Nationality: Hong Kong

#### Lee Jun-fan ####

country_1 = Country.find_or_create_by!(name: 'United States of America')
client_1 = Client.find_or_create_by!(im_client_id: '12345', file_number: '1')
identity_1 = Identity.find_or_create_by!(client_id: client_1.id, identity_number: 'Y-3183346-E', family_name: 'Lee', first_name: 'Bruce', second_name: '', third_name: '', gender: 'Male', country_of_birth_id: country_1.id, nationality: country_1.name, issuing_state_id: country_1.id, serial_number: 'Y-3775136-E')

country_2 = Country.find_or_create_by!(name: 'Hong Kong')
identity_2 = Identity.find_or_create_by!(client_id: client_1.id, identity_number: 'Y-3183347-E', family_name: 'Lee', first_name: 'Jun-fan', second_name: '', third_name: '', gender: 'Male', country_of_birth_id: country_2.id, nationality: country_2.name, issuing_state_id: country_2.id, serial_number: 'Y-3775137-E')

# Identity 1
Movement.find_or_create_by!(identity_id: identity_1.id, direction: 'departure', carrier_date_time: '2007-09-26 20:00:00')
Movement.find_or_create_by!(identity_id: identity_1.id, direction: 'arrival', carrier_date_time: '2007-10-18 06:00:00')
Movement.find_or_create_by!(identity_id: identity_1.id, direction: 'departure', carrier_date_time: '2009-11-05 06:00:00')
Movement.find_or_create_by!(identity_id: identity_1.id, direction: 'arrival', carrier_date_time: '2009-11-08 23:00:00')
Movement.find_or_create_by!(identity_id: identity_1.id, direction: 'departure', carrier_date_time: '2010-02-27 09:00:00')
Movement.find_or_create_by!(identity_id: identity_1.id, direction: 'arrival', carrier_date_time: '2010-02-28 23:00:00')
Movement.find_or_create_by!(identity_id: identity_1.id, direction: 'departure', carrier_date_time: '2010-04-21 17:55:00')
Movement.find_or_create_by!(identity_id: identity_1.id, direction: 'arrival', carrier_date_time: '2010-04-28 16:45:00')
Movement.find_or_create_by!(identity_id: identity_1.id, direction: 'departure', carrier_date_time: '2010-08-20 09:45:00')
Movement.find_or_create_by!(identity_id: identity_1.id, direction: 'arrival', carrier_date_time: '2010-08-22 23:45:00')
Movement.find_or_create_by!(identity_id: identity_1.id, direction: 'departure', carrier_date_time: '2010-11-15 14:00:00')
Movement.find_or_create_by!(identity_id: identity_1.id, direction: 'arrival', carrier_date_time: '2010-11-20 23:00:00')

# Identity 2
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'departure', carrier_date_time: '2011-02-20 16:15:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'arrival', carrier_date_time: '2011-02-24 23:00:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'departure', carrier_date_time: '2011-06-18 11:30:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'arrival', carrier_date_time: '2011-06-26 19:45:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'departure', carrier_date_time: '2012-03-16 11:30:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'arrival', carrier_date_time: '2012-06-23 19:05:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'departure', carrier_date_time: '2012-06-01 18:00:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'arrival', carrier_date_time: '2012-06-07 03:10:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'departure', carrier_date_time: '2012-08-04 20:45:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'arrival', carrier_date_time: '2012-08-30 05:15:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'departure', carrier_date_time: '2013-11-21 10:25:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'arrival', carrier_date_time: '2013-12-08 09:00:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'departure', carrier_date_time: '2014-04-02 21:45:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'arrival', carrier_date_time: '2014-04-19 05:15:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'departure', carrier_date_time: '2015-10-07 17:10:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'arrival', carrier_date_time: '2015-10-13 07:30:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'departure', carrier_date_time: '2015-11-08 09:30:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'arrival', carrier_date_time: '2015-11-13 00:30:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'departure', carrier_date_time: '2016-11-14 08:30:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'arrival', carrier_date_time: '2016-11-21 23:00:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'departure', carrier_date_time: '2017-09-22 13:00:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'arrival', carrier_date_time: '2017-08-28 23:45:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'departure', carrier_date_time: '2017-11-06 09:30:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'arrival', carrier_date_time: '2017-11-11 23:25:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'departure', carrier_date_time: '2017-11-29 09:00:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'arrival', carrier_date_time: '2017-11-30 16:30:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'departure', carrier_date_time: '2018-04-28 05:50:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'arrival', carrier_date_time: '2018-04-29 23:30:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'departure', carrier_date_time: '2018-07-03 08:50:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'arrival', carrier_date_time: '2018-07-06 23:20:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'departure', carrier_date_time: '2018-09-28 06:40:00')
Movement.find_or_create_by!(identity_id: identity_2.id, direction: 'arrival', carrier_date_time: '2018-10-03 23:45:00')

#########################

# James Jones
# Gender change from Male to Female

country_3 = Country.find_or_create_by!(name: 'Australia')
client_2 = Client.find_or_create_by!(im_client_id: '123456', file_number: '2')
identity_3 = Identity.find_or_create_by!(client_id: client_2.id, identity_number: 'Y-4183346-E', family_name: 'Jones', first_name: 'James', second_name: '', third_name: '', gender: 'Male', country_of_birth_id: country_3.id, nationality: country_3.name, issuing_state_id: country_3.id, serial_number: 'Y-4775136-E')
identity_4 = Identity.find_or_create_by!(client_id: client_2.id, identity_number: 'Y-5183346-E', family_name: 'Jones', first_name: 'Jaymie', second_name: '', third_name: '', gender: 'Female', country_of_birth_id: country_3.id, nationality: country_3.name, issuing_state_id: country_3.id, serial_number: 'Y-5775136-E')
Movement.find_or_create_by!(identity_id: identity_3.id, direction: 'arrival', carrier_date_time: 100.days.ago)
Movement.find_or_create_by!(identity_id: identity_3.id, direction: 'departure', carrier_date_time: 90.days.ago)
Movement.find_or_create_by!(identity_id: identity_3.id, direction: 'arrival', carrier_date_time: 80.days.ago)
Movement.find_or_create_by!(identity_id: identity_3.id, direction: 'departure', carrier_date_time: 70.days.ago)

Movement.find_or_create_by!(identity_id: identity_4.id, direction: 'arrival', carrier_date_time: 60.days.ago)
Movement.find_or_create_by!(identity_id: identity_4.id, direction: 'departure', carrier_date_time: 50.days.ago)
Movement.find_or_create_by!(identity_id: identity_4.id, direction: 'arrival', carrier_date_time: 40.days.ago)
Movement.find_or_create_by!(identity_id: identity_4.id, direction: 'departure', carrier_date_time: 30.days.ago)

2.times do
  # Arrived and never left
  identity = FactoryBot.create :identity
  FactoryBot.create :arrival, carrier_date_time: 6.years.ago, identity: identity
end

2.times do
  # arrived, had onl one holiday
  identity = FactoryBot.create :identity
  FactoryBot.create :arrival, carrier_date_time: 6.years.ago, identity: identity

  holiday_length =  Random.rand(10...42)
  holiday_start = Random.rand(50...100).weeks.ago
  holiday_end = holiday_start + holiday_length

  FactoryBot.create :departure, carrier_date_time: holiday_start, identity: identity
  FactoryBot.create :arrival, carrier_date_time: holiday_end, identity: identity
end

# took a really long holiday during
2.times do
  identity = FactoryBot.create :identity
  FactoryBot.create :arrival, carrier_date_time: 6.years.ago, identity: identity

  holiday_start = 140.weeks.ago
  holiday_end = 75.weeks.ago

  FactoryBot.create :departure, carrier_date_time: holiday_start, identity: identity
  FactoryBot.create :arrival, carrier_date_time: holiday_end, identity: identity

end
