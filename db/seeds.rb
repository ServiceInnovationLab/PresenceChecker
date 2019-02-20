# frozen_string_literal: true

# ['brenda.wallace', 'dana.iti'].each do |name|
#   email = "#{name}@dia.govt.nz"
#   User.invite!(email: email) unless User.find_by(email: email)
# end

####### Test scenario #1 #######
# Customer travels in and out of NZ as a Flight Attendant.
# There are cases when an attendant doesn’t register as coming in or out of the country.
# For example records can show that they depart, then depart again, without arriving in between. 
# This would also be at the discretion of the minister.
# However lets run the data through the system and see if we can break it

####### Expected Results #######
# Alert message to prompt a query into this person travel reasons.
# Suggested reasons being that the person may be a flight attendant/pilot.

# identity = FactoryBot.create :identity, family_name: 'Attendant', first_name: 'Flight', second_name: '', third_name: ''
# FactoryBot.create :arrival, carrier_date_time: '20 Jan 2013', identity: identity
# FactoryBot.create :departure, carrier_date_time: '9 Mar 2014', identity: identity
# FactoryBot.create :departure, carrier_date_time: '20 Jan 2014', identity: identity
# FactoryBot.create :arrival, carrier_date_time: '9 Mar 2015', identity: identity
# FactoryBot.create :departure, carrier_date_time: '20 Jan 2015', identity: identity
# FactoryBot.create :departure, carrier_date_time: '9 Mar 2016', identity: identity
# FactoryBot.create :arrival, carrier_date_time: '15 Mar 2016', identity: identity
# FactoryBot.create :departure, carrier_date_time: '26 Aug 2016', identity: identity
# FactoryBot.create :arrival, carrier_date_time: '30 Aug 2015', identity: identity
# FactoryBot.create :departure, carrier_date_time: '1 Nov 2016', identity: identity
# FactoryBot.create :departure, carrier_date_time: '16 Nov 2016', identity: identity
# FactoryBot.create :departure, carrier_date_time: '26 May 2017', identity: identity
# FactoryBot.create :arrival, carrier_date_time: '20 Jun 2017', identity: identity

####### Test scenario #2 #######
# Travel to one of the countries counted as NZ (Cook Islands, Niue, Tokelau & Antarctica).

# *Hazel says:
# There are rules that come from Legislation that can be automated.
# This is the Rules part of the engine model.
# This is the first piece of work to be done on the project

####### Expected results #######
# There is a flag raised in the system to show that this country has been involved in the movements.

# identity = FactoryBot.create :identity, family_name: 'Islands', first_name: 'Cook', second_name: '', third_name: '' 
# FactoryBot.create :arrival, carrier_date_time: '20 Jan 2013', identity: identity

# FactoryBot.create :departure, carrier_date_time: '5 Jan 2015', identity: identity
# FactoryBot.create :arrival, carrier_date_time: '20 Feb 2015', identity: identity
# FactoryBot.create :departure, carrier_date_time: '1 Mar 2016', identity: identity
# FactoryBot.create :arrival, carrier_date_time: '30 Mar 2016', identity: identity
# FactoryBot.create :departure, carrier_date_time: '26 April 2016', identity: identity
# FactoryBot.create :arrival, carrier_date_time: '30  September 2015', identity: identity
# FactoryBot.create :departure, carrier_date_time: '5 Oct 2016', identity: identity
# FactoryBot.create :arrival, carrier_date_time: '30 Dec 2016', identity: identity
# FactoryBot.create :departure, carrier_date_time: '26 May 2017', identity: identity
# FactoryBot.create :arrival, carrier_date_time: '20 Nov 2017', identity: identity
# FactoryBot.create :departure, carrier_date_time: '20 Jan 2018', identity: identity
# FactoryBot.create :arrival, carrier_date_time: '10 Jul 2018', identity: identity

####### Test scenario #3 #######
# Travel to countries counted as NZ (Cook Islands, Niue, Tokelau & Antarctica), but spent time in between all, rather than one or the other.

# *Hazel says: There are rules that come from Legislation that can be automated. This is the Rules part of the engine model.
# This is the first piece of work to be done on the project

####### Expected results #######
# There is a flag raised in the system to show that these countries have been involved in the movements.

###### Test scenario #4 #######
# Customer has three passports and exits NZ on one, and returns to NZ on another.
# On the passports they have different names.

##### Expected results ####
# If there is the same Client ID number grouping these three identities, the departure and arrival dates should be consolidated into the movements table.

country_1 = FactoryBot.create :country, name: 'Canada'
country_2 = FactoryBot.create :country, name: 'Israel'
country_3 = FactoryBot.create :country, name: 'United States of America'

client_1 = FactoryBot.create :client, im_client_id: '12345', file_number: '1'

identity_1 = FactoryBot.create :identity, client_id: client_1.id, identity_number: 'CANA001', family_name: 'Jones', first_name: 'Mary', second_name: 'J', third_name: '', gender: 'Female', country_of_birth_id: country_1.id, nationality: country_1.name, issuing_state_id: country_1.id
identity_2 = FactoryBot.create :identity, client_id: client_1.id, identity_number: 'ISRAEL001', family_name: 'Wailing', first_name: 'Mary', second_name: 'Jane', third_name: '', gender: 'Femaile', country_of_birth_id: country_1.id, nationality: country_2.name, issuing_state_id: country_2.id
identity_3 = FactoryBot.create :identity, client_id: client_1.id, identity_number: 'USOFA001', family_name: 'Cowbowys', first_name: 'MARY JANE', second_name: 'J', third_name: 'Jones', gender: 'Female', country_of_birth_id: country_1.id, nationality: country_3.name, issuing_state_id: country_3.id

FactoryBot.create :arrival, carrier_date_time: '4 Feb 2013', identity: identity_3
FactoryBot.create :departure, carrier_date_time: '9 Mar 2014', identity: identity_1
FactoryBot.create :arrival, carrier_date_time: '15 Mar 2014', identity: identity_2
FactoryBot.create :departure, carrier_date_time: '9 Mar 2016', identity: identity_1
FactoryBot.create :arrival, carrier_date_time: '15 Mar 2016', identity: identity_2
FactoryBot.create :departure, carrier_date_time: '26 Aug 2016', identity: identity_1
FactoryBot.create :arrival, carrier_date_time: '30 Aug 2015', identity: identity_3
FactoryBot.create :departure, carrier_date_time: '1 Nov 2016', identity: identity_3
FactoryBot.create :arrival, carrier_date_time: '16 Nov 2016', identity: identity_3
FactoryBot.create :departure, carrier_date_time: '26 May 2017', identity: identity_2
FactoryBot.create :arrival, carrier_date_time: '20 Jun 2017', identity: identity_3
FactoryBot.create :departure, carrier_date_time: '20 Jan 2018', identity: identity_1
FactoryBot.create :arrival, carrier_date_time: '12 Feb 2018', identity: identity_1

####### Test scenario #5 #######
# Customer has two passports and exits NZ on one, and returns to NZ on another.
# On the passports they have different given names - Given name, and given name and family name.
# This has been recorded in INZ as two separate people, therefore have a different client ID, but they are actually the same person.

##### Expected results ####
# There is a flag raised when the system identifies similarity between country of birth and date of birth. This flag could be used to send to INZ to investigate duplicates.
# (This may be out of scope for this piece of work)

country_1 = FactoryBot.create :country, name: 'India'
country_2 = FactoryBot.create :country, name: 'Britain'

identity_1 = FactoryBot.create :identity, family_name: 'Anand', first_name: 'Prisha', second_name: 'Mehar', third_name: 'Rhea', gender: 'Female', country_of_birth_id: country_1.id, nationality: country_1.name, issuing_state_id: country_1.id

identity_2 = FactoryBot.create :identity, family_name: 'Orwell', first_name: 'Rhea', second_name: 'Prisha', third_name: 'M', gender: 'Female', country_of_birth_id: country_1.id, nationality: country_2.name, issuing_state_id: country_2.id

FactoryBot.create :arrival, carrier_date_time: '20 Feb 2013', identity: identity_1
FactoryBot.create :departure, carrier_date_time: '20 Feb 2014', identity: identity_1
FactoryBot.create :arrival, carrier_date_time: '4 Apr 2014', identity: identity_2
FactoryBot.create :departure, carrier_date_time: '20 Feb 2015', identity: identity_1
FactoryBot.create :arrival, carrier_date_time: '4 Apr 2015', identity: identity_2
FactoryBot.create :departure, carrier_date_time: '9 May 2016', identity: identity_1
FactoryBot.create :arrival, carrier_date_time: '15 May 2016', identity: identity_2
FactoryBot.create :departure, carrier_date_time: '26 Sep 2016', identity: identity_1
FactoryBot.create :arrival, carrier_date_time: '30 Oct 2015', identity: identity_2
FactoryBot.create :departure, carrier_date_time: '1 Nov 2016', identity: identity_1
FactoryBot.create :arrival, carrier_date_time: '16 Dec 2016', identity: identity_2
FactoryBot.create :departure, carrier_date_time: '26 Jun 2017', identity: identity_1
FactoryBot.create :arrival, carrier_date_time: '20 Sep 2017', identity: identity_2
FactoryBot.create :departure, carrier_date_time: '20 Jun 2018', identity: identity_1
FactoryBot.create :arrival, carrier_date_time: '12 Aug 2018', identity: identity_2

####### Test scenario #6  ######
# Customers are away for periods of time while working for the Crown / Military / Govt. 

####### Expected results ######
# # There is a flag raised in the system to show that this person is traveling for Crown / Military / Govt reasons (need to discuss further, may be out of scope for this piece of work)

####### Test scenario #7  ######
# Customers are away for periods of time while their partner/parent is working for the Crown / Military / Govt

######## Expected results #######
# There is a flag raised in the system to show that this person is a partner or child of a person who is traveling for Crown / Military / Govt reasons (need to discuss further, may be out of scope for this piece of work)

####### Test scenario #8 #######
# Customers are away for periods of time but still meet presence requirements on the 5th November 2018

##### Expected results #####
# Applicant still meets presence requirements on the 5th November 2018
# (these dates were tested in Bruteforce)

client_1 = FactoryBot.create :client, im_client_id: '54321', file_number: '1'
identity = FactoryBot.create :identity, client_id: client_1.id, family_name: 'Criteria', first_name: 'Meets', second_name: '', third_name: ''

FactoryBot.create :arrival, carrier_date_time: '20 Jan 2013', identity: identity
FactoryBot.create :departure, carrier_date_time: '10 Jan 2015', identity: identity
FactoryBot.create :arrival, carrier_date_time: '28 Jan 2015', identity: identity
FactoryBot.create :departure, carrier_date_time: '22 Mar 2017', identity: identity
FactoryBot.create :arrival, carrier_date_time: '22 May 2017', identity: identity
FactoryBot.create :departure, carrier_date_time: '7 Jul 2017', identity: identity
FactoryBot.create :arrival, carrier_date_time: '1 Aug 2017', identity: identity
FactoryBot.create :departure, carrier_date_time: '26 Aug 2017', identity: identity
FactoryBot.create :arrival, carrier_date_time: '30  Aug 2017', identity: identity
FactoryBot.create :departure, carrier_date_time: '21 Sep 2017', identity: identity
FactoryBot.create :arrival, carrier_date_time: '4 Oct 2017', identity: identity
FactoryBot.create :departure, carrier_date_time: '1 Nov 2017', identity: identity
FactoryBot.create :arrival, carrier_date_time: '19 Nov 2017', identity: identity
FactoryBot.create :departure, carrier_date_time: '1 Feb 2018', identity: identity
FactoryBot.create :arrival, carrier_date_time: '2 Mar 2018', identity: identity
FactoryBot.create :departure, carrier_date_time: '10 May 2018', identity: identity
FactoryBot.create :arrival, carrier_date_time: '20 May 2018', identity: identity
FactoryBot.create :departure, carrier_date_time: '1 Aug 2018', identity: identity
FactoryBot.create :arrival, carrier_date_time: '5 Aug 2018', identity: identity

####### Test scenario #9 #######
# Customers are away for periods of time and don’t meet presence requirements on the 5th November 2018

##### Expected results #####
# Applicant doesn’t meet presence requirements on the 5th November 2018
#(these dates were tested in Bruteforce)

client_1 = FactoryBot.create :client, im_client_id: '56789', file_number: '1'
identity = FactoryBot.create :identity, client_id: client_1.id, family_name: 'Criteria', first_name: 'Does', second_name: 'Not', third_name: 'Meet'

FactoryBot.create :arrival, carrier_date_time: '20 Jan 2013', identity: identity
FactoryBot.create :departure, carrier_date_time: '30 Jan 2015', identity: identity
FactoryBot.create :arrival, carrier_date_time: '4 Feb 2015', identity: identity
FactoryBot.create :departure, carrier_date_time: '9 Mar 2017', identity: identity
FactoryBot.create :arrival, carrier_date_time: '28 Jun 2017', identity: identity
FactoryBot.create :departure, carrier_date_time: '31 Jul 2017', identity: identity
FactoryBot.create :arrival, carrier_date_time: '4 Aug 2017', identity: identity
FactoryBot.create :departure, carrier_date_time: '26 Aug 2017', identity: identity
FactoryBot.create :arrival, carrier_date_time: '30 Aug 2017', identity: identity
FactoryBot.create :departure, carrier_date_time: '21 Oct 2017', identity: identity
FactoryBot.create :arrival, carrier_date_time: '1 Nov 2017', identity: identity
FactoryBot.create :departure, carrier_date_time: '16 Nov 2017', identity: identity
FactoryBot.create :arrival, carrier_date_time: '19 Nov 2017', identity: identity
FactoryBot.create :departure, carrier_date_time: '26 Feb 2018', identity: identity
FactoryBot.create :arrival, carrier_date_time: '2 Mar 2018', identity: identity
FactoryBot.create :departure, carrier_date_time: '26 May 2018', identity: identity
FactoryBot.create :arrival, carrier_date_time: '1 Jun 2018', identity: identity
FactoryBot.create :departure, carrier_date_time: '19 Aug 2018', identity: identity
FactoryBot.create :arrival, carrier_date_time: '24 Aug 2018', identity: identity

####### Test scenario #10 #######
# Gender change from Male to Female
# Multiple 20 week vacations during preceeding 5 years
# Total days in NZ meets criteria (1492 of 1250)

##### Expected results #####
#Only eligible between June 8th and September 27

client_1 = FactoryBot.create :client, im_client_id: '581119', file_number: '2'
identity_3 = FactoryBot.create :identity, client_id: client_1.id, family_name: 'Jones', first_name: 'James', second_name: '', third_name: '', gender: 'Male'
identity_4 = FactoryBot.create :identity, client_id: client_1.id, family_name: 'Jones', first_name: 'Jaymie', second_name: '', third_name: '', gender: 'Female'
FactoryBot.create :arrival, identity: identity_3, carrier_date_time: 312.weeks.ago
FactoryBot.create :departure, identity: identity_3, carrier_date_time: 300.weeks.ago
FactoryBot.create :arrival, identity: identity_3, carrier_date_time: 280.weeks.ago

FactoryBot.create :departure, identity: identity_4, carrier_date_time: 156.weeks.ago
FactoryBot.create :arrival, identity: identity_4, carrier_date_time: 148.weeks.ago
FactoryBot.create :departure, identity: identity_4, carrier_date_time: 90.weeks.ago
FactoryBot.create :arrival, identity: identity_4, carrier_date_time: 70.weeks.ago

####### Test scenario #11 #######
# Arrived more than five years ago and never left

##### Expected results #####
# Eligible
client_1 = FactoryBot.create :client, im_client_id: '93251', file_number: '2'
identity = FactoryBot.create :identity, client_id: client_1.id, family_name: 'Okay', first_name: 'Simply', second_name: '', third_name: ''
FactoryBot.create :arrival, carrier_date_time: 6.years.ago, identity: identity

####### Test scenario #12 #######
# Arrived more than five years ago
# Only one period overseas which was short enough to meet presence criteria

##### Expected results #####
# Eligible before June 2, 2018 and each year after
# between May 28 2019 and  June 2 2019 (inclusive)
client_1 = FactoryBot.create :client, im_client_id: '821313', file_number: '2'
identity = FactoryBot.create :identity, client_id: client_1.id, family_name: 'Holiday', first_name: 'Short', second_name: '', third_name: ''
FactoryBot.create :arrival, carrier_date_time: '18 Feb 2013', identity: identity

FactoryBot.create :departure, carrier_date_time: '29 Jan 2018', identity: identity
FactoryBot.create :arrival, carrier_date_time: '01 Oct 2018', identity: identity

# We should have think about randomisation along these lines
# Would complicate consistent testing across multiple seed instances
# holiday_length =  Random.rand(10...42)
# holiday_start = Random.rand(50...100)
# holiday_end = holiday_start - holiday_length
# FactoryBot.create :departure, carrier_date_time: holiday_start.weeks.ago, identity: identity
# FactoryBot.create :arrival, carrier_date_time: holiday_end.weeks.ago, identity: identity

####### Test scenario #13 #######
# Was overseas for more than 1 year during preceeding 5 years

##### Expected results #####
# Not Eligible
client_1 = FactoryBot.create :client, im_client_id: '723123', file_number: '2'
identity = FactoryBot.create :identity, client_id: client_1.id, family_name: 'Holiday', first_name: 'Too', second_name: 'Long', third_name: ''
FactoryBot.create :arrival, carrier_date_time: 6.years.ago, identity: identity

holiday_start = 140.weeks.ago
holiday_end = 75.weeks.ago

FactoryBot.create :departure, carrier_date_time: holiday_start, identity: identity
FactoryBot.create :arrival, carrier_date_time: holiday_end, identity: identity
