# frozen_string_literal: true

class EligibilityService
  def initialize(client, day, number_of_days = 30)
    @client = client
    @day = day

    # How many days to calculate in one Open Fisca request
    @number_of_days = number_of_days
  end

  def run!
    @response = calculate(query)

    (0..(@number_of_days - 1)).each do |n|
      day = (Date.parse(@day) + n).strftime('%Y-%m-%d')
      person_name = "ruby_#{day}"

      @eligibility = Eligibility.find_or_initialize_by(client: @client, day: day)

      @eligibility.calculation_data = @response['persons'][person_name]

      # booleans
      @eligibility.minimum_presence = person_result(person_name, 'citizenship__meets_minimum_presence_requirements')[day]
      @eligibility.five_year_presence = person_result(person_name, 'citizenship__meets_5_year_presence_requirement')[day]
      @eligibility.each_year_presence = person_result(person_name, 'citizenship__meets_each_year_minimum_presence_requirements')[day]

      # hash for each rolling year of five
      @eligibility.present_days_by_rolling_year = person_result person_name, 'days_present_in_new_zealand_in_preceeding_year'
      @eligibility.mimimum_presence_by_rolling_year = person_result person_name, 'citizenship__meets_preceeding_single_year_minimum_presence_requirement'

      @eligibility.save!

      puts(@eligibility)
    end

    @eligibility
  end

  def days_to_iterate; end

  def person_result(person_name, key)
    @response['persons'][person_name][key]
  end

  private

  def query
    all_persons = {}
    all_names = []
    (0..@number_of_days).each do |n|
      day = (Date.parse(@day) + n).strftime('%Y-%m-%d')
      person_name = "ruby_#{day}"
      all_names << person_name
      all_persons[person_name] = {
        # The values from the future that we want calculated
        'citizenship__meets_minimum_presence_requirements' => future_days_of_nulls(day),
        'citizenship__meets_each_year_minimum_presence_requirements' => future_days_of_nulls(day),
        'citizenship__meets_5_year_presence_requirement' => future_days_of_nulls(day),
        # the values from past that we want calculated
        'days_present_in_new_zealand_in_preceeding_year' => five_past_years_of_nulls(day),
        'citizenship__meets_preceeding_single_year_minimum_presence_requirement' => five_past_years_of_nulls(day),
        # our input, the presence in NZ
        'present_in_new_zealand' => presence_values
      }
    end

    # Open Fisca will calculate and return the value of a variable, if you pass it in as null.
    {
      'persons' => all_persons,
      # boiler plate that open fisca needs
      'families' => {
        'happy' => {
          'others': all_names
        }
      },
      'titled_properties' => {
        'home' => {
          'others' => all_names
        }
      }
    }
  end

  def five_past_years_of_nulls(day)
    {
      day => nil,
      years_before(day, 1) => nil,
      years_before(day, 2) => nil,
      years_before(day, 3) => nil,
      years_before(day, 4) => nil
    }
  end

  def future_days_of_nulls(day)
    { day => nil }
  end

  def presence_values
    presence = {}

    @client.movements.order(:carrier_date_time).each do |movement|
      if movement.direction == 'arrival'
        presence[movement.day] = true
      elsif movement.direction == 'departure'
        presence[movement.next_day] = false unless movement.only_absent_for_same_day_or_next?
      end
    end

    presence
  end

  def years_before(day, num_years)
    (day.to_date - num_years.year).strftime(EligibilityService.date_format)
  end

  def self.date_format
    '%Y-%m-%d'
  end

  def calculate(query)
    Rails.logger.info 'Calculating'
    Rails.cache.fetch(query) do
      Rails.logger.info 'Requesting from OpenFisca'
      JSON.parse!(HTTParty.post(of_url, body: query.to_json, headers: headers, timeout: timeout).body)
    end
  end

  def headers
    { 'Content-Type' => 'application/json' }
  end

  def of_url
    "#{ENV['OPENFISCA_URL']}/calculate"
  end

  def timeout
    ENV['OPENFISCA_TIMEOUT']
  end
end
