require 'csv'

module Seeder
  class Identities
    def self.seed(spreadsheet_path, logger = Logger.new(STDOUT))
      dataset = CSV.read(spreadsheet_path, headers: true)

      dataset.each do |row|
        model = nil
        begin
        model = Identity.find_or_create_by(
          client_id: Identities.lookup_client_id(row["ClientId"]),
          identity_number: row["IdentityNbr"],
          family_name:row["Surname"],
          first_name:row["Given1"], 
          second_name:row["Given2"], 
          third_name:row["Given3"], 
          gender:row["Gender"], 
          country_of_birth_id: Identities.lookup_country(row["CountryOfBirth"]), 
          nationality: row["Nationality"], 
          issuing_state_id: Identities.lookup_country(row["IssuingState"]), 
          serial_number: row["SerialNbr"])
          # Dob
        rescue StandardError => e
          byebug
        end
        # byebug
      end
    end

    # data cleansing workaround
    def self.lookup_country(country_code)
      default_country_id = Country.find_by(country_code: "01").id
      return default_country_id if country_code == "NULL"
      return default_country_id if country_code == "DD"
      return default_country_id if country_code == "ZZ"
      return default_country_id if country_code == "BU"
      
      Country.find_by(country_code: country_code).id
    end

    def self.lookup_client_id(id)
      client = Client.find_by(im_client_id: id)
      return 0 if client.nil?
      return client.id
    end
  end
end