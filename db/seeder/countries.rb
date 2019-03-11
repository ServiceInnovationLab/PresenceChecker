require 'csv'

module Seeder
  class Countries
    def self.seed(spreadsheet_path, logger = Logger.new(STDOUT))
      dataset = CSV.read(spreadsheet_path, headers: true)

      dataset.each do |row|
        model = Country.find_or_create_by(
          name: row["CountryName"],
          country_code: row["CountryCode"]
        )

        fail unless model.valid? do puts model.errors end
      end
    end
  end
end