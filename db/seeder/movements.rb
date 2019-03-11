require 'csv'

module Seeder
  class Movements
    def self.seed(spreadsheet_path, logger = Logger.new(STDOUT))
      dataset = CSV.read(spreadsheet_path, headers: true)

      logger.info "Loading Movements..."
      dataset.each_with_index do |row, i|
        begin
        model = Movement.find_or_create_by(
          identity_id: Movements.lookup_identity_id(row["SerialNbr"]),
          direction: row["MovementInd"],
          carrier_date_time: DateTime.parse(row["CarrierDateTime"]),
        )
        puts i if (i % 100 == 0) 
        rescue StandardError => e
          byebug
        end
      end
    
      logger.info "Movements Loaded (${Movement.count} in DB)"
    end
    def self.lookup_identity_id(id)
      identity = Identity.find_by(identity_number: id)
      return 0 if identity.nil?
      return identity.id
    end
  end
end