require 'csv'

module Seeder
  class VisaTypes
    def self.seed(spreadsheet_path, logger = Logger.new(STDOUT))
      CSV.read(spreadsheet_path, headers: true)
        .each do |row|
          VisaType.create do |visa_type|
              fail "TODO"
          end
        end
    end
  end
end