# frozen_string_literal: true

class EligibilityService
  def initialize(client, day)
    @client = client
    @day = day
  end

  def run!
    @response = calculate(query)
  end

  ## Returns 7 days forward from @day, with eligibility as a boolean
  ## e.g. {'2019-06-01': true, '2019-06-02': true, '2019-06-03': false ... }
  def meets_minimum_presence_requirements
    person_result 'citizenship__meets_minimum_presence_requirements'
  end

  ## Returns 7 days forward from @day, with eligibility as a boolean
  ## e.g. {'2019-06-01': true, '2019-06-02': true, '2019-06-03': false ... }
  def meets_each_year_minimum_presence_requirements
    person_result 'citizenship__meets_each_year_minimum_presence_requirements'
  end

  ## Returns 7 days forward from @day, with eligibility as a boolean
  ## e.g. {'2019-06-01': true, '2019-06-02': true, '2019-06-03': false ... }
  def meets_5_year_presence_requirement
    person_result 'citizenship__meets_5_year_presence_requirement'
  end

  ## Returns hash e.g. {'2019-06-01': 365, '2018-06-01': 12, '2017-06-01': 132, '2016-06-01': 12, '2015-06-01': 0 }
  def days_by_rolling_year
    person_result 'days_present_in_new_zealand_in_preceeding_year'
  end

  def enough_days_by_rolling_year
    person_result 'citizenship__meets_preceeding_single_year_minimum_presence_requirement'
  end

  private

  def person_result(key)
    @response['persons'][person_name][key]
  end

  def query
    # Open Fisca will calculate and return the value of a variable, if you pass it in as null.
    {
      'persons' => {
        person_name => {
          # The values from the future that we want calculated
          'citizenship__meets_minimum_presence_requirements' => future_days_of_nulls,
          'citizenship__meets_each_year_minimum_presence_requirements' => future_days_of_nulls,
          'citizenship__meets_5_year_presence_requirement' => future_days_of_nulls,
          # the values from past that we want calculated
          'days_present_in_new_zealand_in_preceeding_year' => five_past_years_of_nulls,
          'citizenship__meets_preceeding_single_year_minimum_presence_requirement' => five_past_years_of_nulls,
          # our input, the presence in NZ
          'present_in_new_zealand' => presence_values
        }
      },
      # boiler plate that open fisca needs
      'families' => {
        'happy' => {
          'others': ['Ruby']
        }
      },
      'titled_properties' => {
        'home' => {
          'others' => ['Ruby']
        }
      }
    }
  end

  def five_past_years_of_nulls
    {
      @day => nil,
      years_before(1) => nil,
      years_before(2) => nil,
      years_before(3) => nil,
      years_before(4) => nil
    }
  end

  def future_days_of_nulls
    days = {}

    1.times do |i|
      days[@day.to_date + i] = nil
    end
    days
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

  def years_before(num_years)
    (@day.to_date - num_years.year).strftime(date_format)
  end

  def date_format
    '%Y-%m-%d'
  end

  def person_name
    'Ruby'
  end

  def calculate(query)
    Rails.cache.fetch(query) do
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
