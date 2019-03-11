require 'csv'

module Seeder
  class Visas
    def self.seed(spreadsheet_path, logger = Logger.new(STDOUT))
      CSV.read(spreadsheet_path, headers: true)
        .each do |row|
          Visa.create do |movement|
            fail "TODO"
          end
      end
    end
  end
end