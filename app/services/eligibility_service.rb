# frozen_string_literal: true

class EligibilityService
  def initialize(client, day)
    @client = client
    @day = day
  end

  def run!
    @response = calculate(query)
  end

  ## Returns 100 days forward from @day, with eligibliity as a boolean
  ## e.g. {'2019-06-01': true, '2019-06-02': true, '2019-06-03': false ... }
  def meets_minimum_presence_requirements
    @response['persons'][person_name]['citizenship__meets_minimum_presence_requirements']
  end

  ## Returns boolean
  def meets_each_year_minimum_presence_requirements
    @response['persons'][person_name]['citizenship__meets_each_year_minimum_presence_requirements'][@day]
  end

  ## Returns boolean
  def meets_5_year_presence_requirement
    @response['persons'][person_name]['citizenship__meets_5_year_presence_requirement'][@day]
  end

  ## Returns hash e.g. {'2019-06-01': 365, '2018-06-01': 12, '2017-06-01': 132, '2016-06-01': 12, '2015-06-01': 0 }
  def days_by_rolling_year
    @response['persons'][person_name]['days_present_in_new_zealand_in_preceeding_year']
  end

  private

  def query
    {
      'persons' => {
        person_name => {
          'citizenship__meets_minimum_presence_requirements' => one_hundred_days_of_nulls,
          'citizenship__meets_each_year_minimum_presence_requirements' => {
            @day => nil
          },
          'citizenship__meets_5_year_presence_requirement' => {
            @day => nil
          },
          'days_present_in_new_zealand_in_preceeding_year' => {
            @day => nil,
            years_before(1) => nil,
            years_before(2) => nil,
            years_before(3) => nil,
            years_before(4) => nil
          },
          'present_in_new_zealand' => presence_values
        }
      },
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

  def one_hundred_days_of_nulls
    days = {}
  
    2.times do |i|
      days[@day.to_date + i] = nil
    end
    days
  end

  def presence_values
    presence = {}

    @client.movements.order(:carrier_date_time).each do |movement|
      if movement.direction == 'arrival'
        presence[movement.carrier_date_time.to_date.strftime(date_format)] = true
      elsif movement.direction == 'departure'
        # today they're here, tomorrow they're not
        # today = movement.carrier_date_time.to_date.strftime(date_format)
        tomorrow = (movement.carrier_date_time.to_date + 1).strftime(date_format)
        # presence[today] = true
        presence[tomorrow] = false
      end
    end

    presence
  end

  def date_format
    '%Y-%m-%d'
  end

  def years_before(num_years)
    (@day.to_date - num_years.year).strftime(date_format)
  end

  def person_name
    'Ruby'
  end

  def calculate(query)
    # Rails.cache.fetch("@client.id/@day.date.strftime(date_format)", expires_in: 12.hours) do
      JSON.parse(HTTParty.post(of_url, body: query.to_json, headers: headers).body)
    # end
  end

  def headers
    { 'Content-Type' => 'application/json' }
  end

  def of_url
    "#{ENV['OPENFISCA_URL']}/calculate"
  end
end
