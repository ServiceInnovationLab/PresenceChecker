# frozen_string_literal: true

module OpenFisca
  # Calculates OpenFisca variables for Clients based on locally available data
  class ClientVariablesService
    def initialize(client)
      @client = client
    end

    def present_in_new_zealand
      presence = {}

      @client.movements.order(:carrier_date_time).each do |movement|
        if movement.arrival?
          presence[movement.day] = true
        elsif movement.departure?
          presence[movement.next_day] = false unless movement.only_absent_for_same_day_or_next?
        end
      end

      presence
    end

    def immigration__entitled_to_indefinite_stay
      # default to calculating visa eligibility from the movements table
      entitled_to_indefinite_stay_by_visas
    end

    private

    # Calculate visa eligibility periods based on the visa types attached to Movements
    def entitled_to_indefinite_stay_by_movements
      eligibility = {}

      @client.movements.order(:carrier_date_time).each do |movement|
        if movement.arrival?
          eligibility[movement.day] = true if VisaType::INDEFINITE_VISA_TYPES.include?(movement.visa_type)
        elsif movement.departure?
          eligibility[movement.next_day] = false unless movement.only_absent_for_same_day_or_next?
        end
      end

      eligibility
    end

    # Calculate visa eligibility periods based on granted visas
    #
    # Assumes visas are valid from the start date of the visa, and become invalid
    # the day after the expiry date.
    #
    # Note - expects on OpenFisca to understand obscure cases like overlapping
    # visas. Needs testing.
    def entitled_to_indefinite_stay_by_visas
      eligibility = {}

      @client.visas.indefinite.each do |visa|
        eligibility[visa.start_date] = true
        eligibility[visa.expiry_date + 1.day] = false
      end

      eligibility
    end

  end
end
