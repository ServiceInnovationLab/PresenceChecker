require 'csv'

module Seeder
  class Clients
    def self.seed(spreadsheet_path, logger = Logger.new(STDOUT))
      dataset = CSV.read(spreadsheet_path, headers: true)

      dataset.each do |row|
        Client.find_or_create_by(
          im_client_id: row["ClientId"]
        ) do |client|
          client.file_number = row["FileNumber"]
        end
      end
    end
  end
end